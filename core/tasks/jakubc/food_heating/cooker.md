# Piekarnik Lamona – specyfikacja robocza

## Źródła
- [We Love Kitchens – Lamona LAM3677 Single Split Cavity Multi-F 60cm Built In Oven](https://www.welovekitchens.co.uk/products/lam3675-lamona-built-in-electric-60cm-black-single-oven) (dostęp 2025-11-22, mirror przez r.jina.ai) – dane katalogowe serii 80 l.
- [Manualslib – Lamona LAM3412 Instructions and Installation](https://www.manualslib.com/manual/3214945/Lamona-Lam3412.html) – dokumentacja funkcji i obsługi modeli jednorozdzielczych (przydatne dla starszych jednostek 65 l).

## Najważniejsze dane katalogowe (LAM3677 – wersja współczesna)
- **Producent / linia:** Lamona / Howdens.
- **Model referencyjny:** LAM3677 (następca LAM3675/LAM3676) – największa obecnie dostępna komora pojedyncza w portfolio Lamona.
- **Pojemność komory:** 80 litrów (największa pojemność w serii single-oven Lamona).
- **Konstrukcja:** single oven z opcjonalną przegrodą dzielącą komorę na dwie strefy termiczne → można piec dwie potrawy przy różnych temperaturach, bez mieszania zapachów.
- **Funkcje:** multifunkcja wentylatora, grill, możliwość pracy jako „double” w obudowie 60 cm.
- **Powłoka:** emalia easy-clean ułatwiająca usuwanie tłuszczu.
- **Klasa energetyczna:** A.
- **Wymiary zabudowy (S×W×G):** 594 × 595 × 567 mm (standardowa nisza 60 cm).
- **Gwarancja katalogowa:** 3 lata producenta (dla nowych egzemplarzy sprzedawanych przez Howdens/We Love Kitchens).

## Funkcje i obsługa (bazowane na manualu Lamona LAM3412)
- **Tryby grzania:** lampa (światło + chłodzenie), grzałka kołowa + wentylator (równomierne pieczenie kilku potraw), grill + wentylator (szybsze opiekanie mięs), sam grill (górna grzałka), tryb rozmrażania (wentylator bez grzania). Wszystkie symbole i opisy znajdują się w instrukcji.
- **Procedura pierwszego uruchomienia:** usunąć opakowania, przetrzeć komorę, wyjąć blachy, zamknąć drzwi, ustawić najwyższą temperaturę i tryb grilla/termoobieg na ~30 min przy dobrej wentylacji pomieszczenia.
- **Ustawianie zegara:** tryb zegara z przyciskiem `Mode`, sterowanie `+/-`.
- **Obsługa podstawowa:** po ustawieniu godziny zamknąć drzwi, ustawić termostat i pokrętło funkcji – piesarnika utrzyma temperaturę, a lampka grzania zgaśnie po osiągnięciu zadanej wartości.
- **Konserwacja:** czyścić wilgotną szmatką z łagodnym detergentem po każdym użyciu; zdejmowane szyby i prowadnice można myć w zmywarce; nie używać ostrych narzędzi.
- **Bezpieczeństwo:** funkcja Child Lock (wyłączenie poprzez dłuższe przytrzymanie „Set +”), kontrola zasilania i bezpieczników w razie błędów.

## Parametry robocze aktualnego egzemplarza w warsztacie
- **Deklarowana moc grzewcza:** 2000 W (szacunek użytkownika dla jednostki Lamona montowanej ~10 lat temu; brak oryginalnej tabliczki).
- **Wiek urządzenia:** ok. 10 lat → należy uwzględnić naturalne zużycie elementów grzejnych i izolacji.
- **Przyjęta degradacja wydajności:** −20 % względem danych katalogowych → moc efektywna ~1600 W (współczynnik 0,8).
- **Konsekwencje:** nagrzewanie do 200 °C trwa obecnie ~20–25 min (model fizyczny w `SOP.md`), dlatego planując procesy kulinarne ustawiamy w terminarzu dodatkowe ~5 min buforu na każdą kolejną partię.
- **Kontrola:** stosować zewnętrzny termometr (termopara) do walidacji temperatury realnej vs. ustawionej i korygować czasy.

## Mapowanie danych katalogowych ↔ egzemplarz warsztatowy
| Parametr                 | Wartość katalogowa (LAM3677) | Szacunek dla egzemplarza 10-letniego |
|--------------------------|------------------------------|--------------------------------------|
| Pojemność komory        | 80 l                          | ~65 l (starszy model; brak separatora) |
| Moc nominalna           | 2,0–2,4 kW (typowe dla fan ovens 60 cm) | 2,0 kW (z tabliczki / doświadczenia) |
| Efektywność energetyczna| Klasa A                       | Klasa A w momencie zakupu, realnie A− (degradacja izolacji) |
| Powłoka                  | Easy-clean enamel             | Easy-clean, wymaga częstego czyszczenia by utrzymać przewodność cieplną |
| Tryby grzania            | Multifunkcja + separator      | Wentylator + grill (bez oryginalnego separatora; korzystamy z własnego rig-u) |

## Dodatkowe obserwacje serwisowe i wydajnościowe
- Dwupiętrowy rig w obecnej konfiguracji mieści się dzięki dużej komorze – prowadnice nie wymagają modyfikacji.
- Jeśli oryginalny separator jest niedostępny, można rozważyć wykonanie przegrody custom (np. aluminium/stal) – pamiętać o dylatacjach termicznych.
- Czyszczenie powłoki easy-clean po każdym cyklu minimalizuje spadek efektywności (nagromadzenie tłuszczu działa jak izolator).
- Długie nagrzewanie można kompensować poprzez wcześniejsze uruchomienie termoobiegu (np. 10 min przed realnym startem zadania) oraz monitorowanie temperatury na obu piętrach rig-u.
- W razie spadku temperatury lub błędu LOC: sprawdzić Child Lock, bezpieczniki oraz poprawność zasilania zgodnie z instrukcją LAM3412 (sekcja rozwiązywania problemów).

## Notatka wydajności (-20 %)
Skalowanie wyników:
- **Czasy nagrzewania / pieczenia** mnożymy przez 1,25 (odwrotność 0,8).
- **Temperatura** – jeśli termometr pokazuje niższą wartość niż zadana, zwiększamy nastawę o ~10–15 °C, ale monitorujemy, by nie przekroczyć 230 °C (ograniczenia materiałowe uszczelki drzwi).
- **Wydatek energetyczny** – realna konsumpcja dla cyklu nagrzewania 20 min + pieczenie 20 min ≈ 1,6 kW × (2/3 h) ≈ 1,07 kWh, czyli ~20 % mniej niż w katalogu, ale kosztem dłuższego czasu.
