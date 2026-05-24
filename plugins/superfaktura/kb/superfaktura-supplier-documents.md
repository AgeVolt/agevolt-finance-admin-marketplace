# SuperFaktura Supplier Documents KB

Tato KB je pre dodavatelsku stranu SuperFaktury: dodavatelske objednavky, nakladove faktury, dodavatelske dodacie listy, sparovanie dokladov a spracovanie PDF faktur od dodavatelov.

Klientske ponuky, predajne objednavky, zalohove faktury, ostre faktury, odoslanie klientovi a uhrady klientskych dokladov patria do skillu `superfaktura-client-side`.

## Typy Dodavatelskych Dokladov

| Typ alebo tool | Pouzitie |
| --- | --- |
| `reverse_order` | Dodavatelska alebo nakupna objednavka vystavena voci dodavatelovi. |
| `sf_expenses_*` | Dodavatelska alebo nakladova faktura. |
| `delivery` | Dodaci list, iba ked je jasne, ci ide o SuperFaktura doklad alebo referenciu k dodavatelskej objednavke/fakture. |

Nepouzivaj `type=order` pre dodavatelsku objednavku; `order` je predajna objednavka na klientskej strane.

## Povolene Nastroje

- Dodavatelske objednavky: `sf_documents_list`, `sf_documents_get`, `sf_documents_create_preview`, `sf_documents_create`, `sf_documents_update_preview`, `sf_documents_update`, `sf_documents_delete_preview`, `sf_documents_delete` s `type=reverse_order`.
- Dodavatelske a nakladove faktury: `sf_expenses_list`, `sf_expenses_get`, `sf_expenses_create_preview`, `sf_expenses_create`, `sf_expenses_update_preview`, `sf_expenses_update`, `sf_expenses_delete_preview`, `sf_expenses_delete`.
- Dodavatelia alebo partneri: `sf_clients_search`, `sf_clients_list`, `sf_clients_get`, iba ak SuperFaktura drzi dodavatela v rovnakom partner registri.
- Ciselniky: `sf_value_lists_*`, iba ked treba overit menu, DPH, kategoriiu, sposob platby alebo inu hodnotu.
- Priame API: `sf_api_get`, `sf_api_write_preview`, `sf_api_write`, iba ked strukturovany tool nestaci a je znama presna API cesta aj payload.

## Bezpecny Zapis

Kazdy zapis, zmazanie, sparovanie, nahratie PDF alebo zmena stavu ma tri kroky:

1. Najdi presny ciel a over dodavatela, cislo dokladu, sumy, menu, datum vystavenia, datum dodania, splatnost a DPH.
2. Zavolaj preview tool, napriklad `sf_documents_create_preview`, `sf_expenses_create_preview` alebo `sf_expenses_update_preview`.
3. Pouzivatelovi ukaz zhrnutie, riziko a `confirmation_id`.
4. Execute tool volaj az po explicitnom potvrdeni v aktualnej konverzacii.
5. Execute toolu posli iba `confirmation_id`.

Ak chyba dodavatel, suma, DPH, mena, datum, splatnost, polozky, cislo dodavatelskej faktury alebo cielova objednavka/dodaci list, najprv sa opytaj. Nevymyslaj obchodne ani uctovne data.

## Workflowy

### Dodavatelska Objednavka

- Vyhladaj dodavatela alebo si vypytaj jeho presnu identifikaciu.
- Pouzi `sf_documents_create_preview` s `type=reverse_order`.
- Do poloziek prenes nazov, mnozstvo, jednotku, cenu, menu a DPH iba z potvrdeneho zadania.
- Execute pouzi az po potvrdeni preview.

### Dodavatelska Nakladova Faktura

- Ak faktura prisla ako PDF, najprv z nej vyextrahuj data: dodavatel, ICO/DIC/IC DPH, cislo faktury, VS, suma, mena, DPH, datum vystavenia, datum dodania, splatnost a polozky.
- Vyhladaj existujuceho dodavatela alebo priprav preview doplnenia partnera, ak to workflow vyzaduje.
- Pouzi `sf_expenses_create_preview` pri novej fakture alebo `sf_expenses_update_preview` pri uprave existujucej faktury.
- Zachovaj originalne cislo faktury dodavatela a variabilny symbol.

### Sparovanie S Objednavkou Alebo Dodacim Listom

- Najprv najdi kandidatsku dodavatelsku objednavku (`type=reverse_order`) a existujucu nakladovu fakturu (`sf_expenses_*`).
- Ak existuje strukturovane pole pre vazbu v payload-e, pouzi ho cez preview.
- Ak strukturovana vazba nie je znama, nepouzivaj vymyslene pole. Priprav preview s bezpecnou poznamkou/referenciou iba vtedy, ked ju SuperFaktura payload podporuje.
- Pri nejasnych kandidatoch ukaz zoznam moznosti a vypytaj vyber.

### Dodavatelsky Dodaci List

- Ak ma vzniknut ako samostatny SuperFaktura doklad, pouzi `sf_documents_create_preview` s `type=delivery` iba po overeni, ze ide o spravny typ pre danu operaciu.
- Ak je dodaci list iba priloha alebo referencia k dodavatelskej fakture, uprav cielovu fakturu/objednavku cez podporovany preview payload.

### PDF Faktura Od Dodavatela

- PDF ani jeho obsah neukladaj do Git alebo markdown suborov.
- Z PDF vytaz data a priprav `sf_expenses_create_preview` alebo `sf_expenses_update_preview`.
- Priame nahratie PDF rob iba vtedy, ked aktualny MCP/API payload jasne podporuje prilohu alebo ked je znama presna SuperFaktura API cesta; vtedy pouzi `sf_api_write_preview` a az po potvrdeni `sf_api_write`.
- Ak MCP v aktualnej verzii nevie PDF prilohu nahrat, vytvor/zmen nakladovu fakturu cez preview a jasne povedz, ze nahratie prilohy vyzaduje doplnenie MCP alebo presny podporovany endpoint.
