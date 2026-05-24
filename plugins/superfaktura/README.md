# SuperFaktura

Plugin pre SuperFakturu v AgeVolt finance/admin marketplace.

Obsahuje:

- skill `superfaktura-client-side` pre klientov, ponuky, predajne objednavky, faktury, dodacie listy, odoslanie a uhrady,
- skill `superfaktura-supplier-side` pre dodavatelske objednavky, nakladove faktury, dodavatelske dodacie listy, sparovanie dokladov a spracovanie PDF faktur,
- KB pre klientske aj dodavatelske workflowy,
- MCP konfiguraciu pre AgeVolt SuperFaktura server.

Zapis, zmazanie, odoslanie a uhrada sa nikdy nevykonavaju priamo: najprv sa pripravi preview, pouzivatel potvrdi aktualnu konverzaciu a az potom sa vola execute s `confirmation_id`. Realne customer, supplier, fakturacne data ani PDF subory nepatria do Git repozitara.
