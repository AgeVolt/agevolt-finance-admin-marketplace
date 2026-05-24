# AgeVolt Finance Admin Marketplace

Marketplace pre financie, administrativu a opravnene prehlady vedenia.

Ma sluzit ludom, ktori pracuju s fakturami, pohladavkami, platbami, administrativnymi dokumentmi, reportmi a financnymi prehladmi. Typicke buduce oblasti su SuperFaktura, neuhradene faktury, cash overview, mesacne reporty a administrativne podklady.

Tento marketplace pracuje s citlivymi financnymi datami. Pluginy musia mat jasneho vlastnika, opravnenia, read/preview krok a pravidla pre zapis.

## Pluginy

- `superfaktura` - SuperFaktura cez AgeVolt MCP: klientske ponuky, predajne objednavky, faktury, dodacie listy, odosielanie a uhrady; dodavatelske objednavky, nakladove faktury, dodavatelske dodacie listy, sparovanie dokladov a spracovanie PDF podkladov.

Kazdy zapis, zmazanie, odoslanie alebo uhrada musi ist cez preview -> explicitne potvrdenie -> execute.
