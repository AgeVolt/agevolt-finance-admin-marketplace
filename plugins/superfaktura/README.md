# SuperFaktura

Plugin pre klientsku cast SuperFaktury v AgeVolt finance/admin marketplace.

Obsahuje:

- skill `superfaktura-client-side`,
- KB pre klientov, ponuky, objednavky, faktury, dodacie listy, odoslanie a uhrady,
- MCP konfiguraciu pre AgeVolt SuperFaktura server.

Tento plugin prvej verzie neriesi nakupne objednavky, naklady, sklad, pokladnu, tagy ani ine vedlajsie casti SuperFaktury. Zapis, zmazanie, odoslanie a uhrada sa nikdy nevykonavaju priamo: najprv sa pripravi preview, pouzivatel potvrdi aktualnu konverzaciu a az potom sa vola execute s `confirmation_id`.
