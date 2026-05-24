# AgeVolt Finance Admin Marketplace

Marketplace pre financie, administrativu a opravnene prehlady vedenia.

Ma sluzit ludom, ktori pracuju s fakturami, pohladavkami, platbami, administrativnymi dokumentmi, reportmi a financnymi prehladmi. Typicke buduce oblasti su SuperFaktura, neuhradene faktury, cash overview, mesacne reporty a administrativne podklady.

Tento marketplace pracuje s citlivymi financnymi datami. Pluginy musia mat jasneho vlastnika, opravnenia, read/preview krok a pravidla pre zapis.

## Pluginy

- `superfaktura` - klientska cast SuperFaktury cez AgeVolt MCP: klienti, cenove ponuky, predajne objednavky, zalohove faktury, ostre faktury, dodacie listy, uhrady a odosielanie.

Kazdy zapis, zmazanie, odoslanie alebo uhrada musi ist cez preview -> explicitne potvrdenie -> execute.
