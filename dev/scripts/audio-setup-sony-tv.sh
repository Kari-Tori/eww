#!/usr/bin/env bash
# audio-setup-sony-tv.sh - Automatyczna konfiguracja audio dla SONY TV
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Urządzenie docelowe
readonly SONY_TV_CARD="alsa_card.pci-0000_01_00.1"
readonly SONY_TV_PROFILE="output:hdmi-stereo-extra1"
readonly SONY_TV_SINK="alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"

# Logowanie
log_info() {
    echo -e "${BLUE}[EWW Audio]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[EWW Audio]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[EWW Audio]${NC} $*" >&2
}

log_error() {
    echo -e "${RED}[EWW Audio]${NC} $*" >&2
}

# Czekaj na PulseAudio
wait_for_pulseaudio() {
    local max_attempts=30
    local attempt=0

    log_info "Czekam na PulseAudio..."

    while ! pactl info &>/dev/null; do
        ((attempt++))
        if [[ $attempt -ge $max_attempts ]]; then
            log_error "PulseAudio nie odpowiada po ${max_attempts} próbach"
            return 1
        fi
        sleep 1
    done

    log_success "PulseAudio dostępny"
    return 0
}

# Ustaw profil karty
set_card_profile() {
    log_info "Ustawiam profil karty: ${SONY_TV_PROFILE}"

    if ! pactl set-card-profile "$SONY_TV_CARD" "$SONY_TV_PROFILE" 2>/dev/null; then
        log_error "Nie można ustawić profilu karty"
        return 1
    fi

    sleep 1
    log_success "Profil karty ustawiony"
    return 0
}

# Ustaw domyślne wyjście
set_default_sink() {
    log_info "Ustawiam domyślne wyjście: ${SONY_TV_SINK}"

    if ! pactl set-default-sink "$SONY_TV_SINK" 2>/dev/null; then
        log_error "Nie można ustawić domyślnego wyjścia"
        return 1
    fi

    log_success "Domyślne wyjście ustawione"
    return 0
}

# Ustaw głośność
set_volume() {
    local volume="${1:-100%}"

    log_info "Ustawiam głośność: ${volume}"

    if ! pactl set-sink-volume "$SONY_TV_SINK" "$volume" 2>/dev/null; then
        log_warn "Nie można ustawić głośności"
        return 1
    fi

    log_success "Głośność ustawiona na ${volume}"
    return 0
}

# Przenieś istniejące strumienie
move_existing_streams() {
    log_info "Przenoszę istniejące strumienie audio..."

    local stream_ids
    stream_ids=$(pactl list short sink-inputs 2>/dev/null | awk '{print $1}')

    if [[ -z "$stream_ids" ]]; then
        log_info "Brak aktywnych strumieni do przeniesienia"
        return 0
    fi

    local moved=0
    local failed=0

    for stream_id in $stream_ids; do
        if pactl move-sink-input "$stream_id" "$SONY_TV_SINK" 2>/dev/null; then
            ((moved++)) || true
        else
            ((failed++)) || true
        fi
    done

    if [[ $moved -gt 0 ]]; then
        log_success "Przeniesiono ${moved} strumieni audio"
    fi

    if [[ $failed -gt 0 ]]; then
        log_warn "Nie udało się przenieść ${failed} strumieni"
    fi

    return 0
}

# Wyświetl status
show_status() {
    log_info "Status konfiguracji audio:"

    local default_sink
    default_sink=$(pactl get-default-sink 2>/dev/null || echo "NIEZNANY")

    if [[ "$default_sink" == "$SONY_TV_SINK" ]]; then
        log_success "✓ Domyślne wyjście: SONY TV (${SONY_TV_SINK})"
    else
        log_warn "✗ Domyślne wyjście: ${default_sink}"
    fi

    local volume
    volume=$(pactl get-sink-volume "$SONY_TV_SINK" 2>/dev/null | grep -oP '\d+%' | head -1 || echo "N/A")
    log_info "  Głośność: ${volume}"

    local stream_count
    stream_count=$(pactl list short sink-inputs 2>/dev/null | wc -l || echo "0")
    log_info "  Aktywne strumienie: ${stream_count}"

    return 0
}

# Główna funkcja
main() {
    log_info "=== Konfiguracja audio GERC - SONY TV ==="

    # Czekaj na PulseAudio
    if ! wait_for_pulseaudio; then
        exit 1
    fi

    # Dodatkowe opóźnienie dla stabilności
    sleep 2

    # Ustaw profil karty
    if ! set_card_profile; then
        log_error "Konfiguracja nie powiodła się"
        exit 1
    fi

    # Ustaw domyślne wyjście
    if ! set_default_sink; then
        log_error "Konfiguracja nie powiodła się"
        exit 1
    fi

    # Ustaw głośność
    set_volume "100%"

    # Przenieś istniejące strumienie
    move_existing_streams

    # Pokaż status
    echo ""
    show_status
    echo ""

    log_success "=== Konfiguracja audio zakończona ==="
}

main "$@"
