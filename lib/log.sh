# shell lib: log
log(){ printf "%s %s\n" "$(date '+%F %T')" "$*"; }
