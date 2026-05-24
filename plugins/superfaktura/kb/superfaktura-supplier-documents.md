# SuperFaktura Supplier Documents KB

Tato KB je pre dodavatelsku stranu SuperFaktury: dodavatelske objednavky, nakladove faktury, dodavatelske dodacie listy, sparovanie dokladov a spracovanie PDF faktur od dodavatelov.

Klientske ponuky, predajne objednavky, zalohove faktury, ostre faktury, odoslanie klientovi a uhrady klientskych dokladov patria do skillu `superfaktura-client-side`.

## Typy Dodavatelskych Dokladov

| Typ alebo tool | Pouzitie |
| --- | --- |
| `reverse_order` | Dodavatelska alebo nakupna objednavka vystavena voci dodavatelovi. |
| `sf.expenses.*` | Dodavatelska alebo nakladova faktura. |
| `delivery` | Dodaci list, iba ked je jasne, ci ide o SuperFaktura doklad alebo referenciu k dodavatelskej objednavke/fakture. |

Nepouzivaj `type=order` pre dodavatelsku objednavku; `order` je predajna objednavka na klientskej strane.

## Povolene Nastroje

- Dodavatelske objednavky: `sf.documents.list`, `sf.documents.get`, `sf.documents.create_preview`, `sf.documents.create`, `sf.documents.update_preview`, `sf.documents.update`, `sf.documents.delete_preview`, `sf.documents.delete` s `type=reverse_order`.
- Dodavatelske a nakladove faktury: `sf.expenses.list`, `sf.expenses.get`, `sf.expenses.create_preview`, `sf.expenses.create`, `sf.expenses.update_preview`, `sf.expenses.update`, `sf.expenses.delete_preview`, `sf.expenses.delete`.
- Dodavatelia alebo partneri: `sf.clients.search`, `sf.clients.list`, `sf.clients.get`, iba ak SuperFaktura drzi dodavatela v rovnakom partner registri.
- Ciselniky: `sf.value_lists.*`, iba ked treba overit menu, DPH, kategoriiu, sposob platby alebo inu hodnotu.
- Priame API: `sf.api.get`, `sf.api.write_preview`, `sf.api.write`, iba ked strukturovany tool nestaci a je znama presna API cesta aj payload.

## Bezpecny Zapis

Kazdy zapis, zmazanie, sparovanie, nahratie PDF alebo zmena stavu ma tri kroky:

1. Najdi presny ciel a over dodavatela, cislo dokladu, sumy, menu, datum vystavenia, datum dodania, splatnost a DPH.
2. Zavolaj preview tool, napriklad `sf.documents.create_preview`, `sf.expenses.create_preview` alebo `sf.expenses.update_preview`.
3. Pouzivatelovi ukaz zhrnutie, riziko a `confirmation_id`.
4. Execute tool volaj az po explicitnom potvrdeni v aktualnej konverzacii.
5. Execute toolu posli iba `confirmation_id`.

Ak chyba dodavatel, suma, DPH, mena, datum, splatnost, polozky, cislo dodavatelskej faktury alebo cielova objednavka/dodaci list, najprv sa opytaj. Nevymyslaj obchodne ani uctovne data.

## Workflowy

### Dodavatelska Objednavka

- Vyhladaj dodavatela alebo si vypytaj jeho presnu identifikaciu.
- Pouzi `sf.documents.create_preview` s `type=reverse_order`.
- Do poloziek prenes nazov, mnozstvo, jednotku, cenu, menu a DPH iba z potvrdeneho zadania.
- Execute pouzi az po potvrdeni preview.

### Dodavatelska Nakladova Faktura

- Ak faktura prisla ako PDF, najprv z nej vyextrahuj data: dodavatel, ICO/DIC/IC DPH, cislo faktury, VS, suma, mena, DPH, datum vystavenia, datum dodania, splatnost a polozky.
- Vyhladaj existujuceho dodavatela alebo priprav preview doplnenia partnera, ak to workflow vyzaduje.
- Pouzi `sf.expenses.create_preview` pri novej fakture alebo `sf.expenses.update_preview` pri uprave existujucej faktury.
- Zachovaj originalne cislo faktury dodavatela a variabilny symbol.

### Sparovanie S Objednavkou Alebo Dodacim Listom

- Najprv najdi kandidatsku dodavatelsku objednavku (`type=reverse_order`) a existujucu nakladovu fakturu (`sf.expenses.*`).
- Ak existuje strukturovane pole pre vazbu v payload-e, pouzi ho cez preview.
- Ak strukturovana vazba nie je znama, nepouzivaj vymyslene pole. Priprav preview s bezpecnou poznamkou/referenciou iba vtedy, ked ju SuperFaktura payload podporuje.
- Pri nejasnych kandidatoch ukaz zoznam moznosti a vypytaj vyber.

### Dodavatelsky Dodaci List

- Ak ma vzniknut ako samostatny SuperFaktura doklad, pouzi `sf.documents.create_preview` s `type=delivery` iba po overeni, ze ide o spravny typ pre danu operaciu.
- Ak je dodaci list iba priloha alebo referencia k dodavatelskej fakture, uprav cielovu fakturu/objednavku cez podporovany preview payload.

### PDF Faktura Od Dodavatela

- PDF ani jeho obsah neukladaj do Git alebo markdown suborov.
- Z PDF vytaz data a priprav `sf.expenses.create_preview` alebo `sf.expenses.update_preview`.
- Priame nahratie PDF rob iba vtedy, ked aktualny MCP/API payload jasne podporuje prilohu alebo ked je znama presna SuperFaktura API cesta; vtedy pouzi `sf.api.write_preview` a az po potvrdeni `sf.api.write`.
- Ak MCP v aktualnej verzii nevie PDF prilohu nahrat, vytvor/zmen nakladovu fakturu cez preview a jasne povedz, ze nahratie prilohy vyzaduje doplnenie MCP alebo presny podporovany endpoint.
