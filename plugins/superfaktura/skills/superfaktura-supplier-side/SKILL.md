---
name: superfaktura-supplier-side
description: Pouzi pri dodavatelskej praci so SuperFakturou v AgeVolt, najma ked treba citat, vytvorit, upravit, zmazat alebo sparovat dodavatelsku objednavku, dodavatelsku alebo nakladovu fakturu, dodavatelsky dodaci list, alebo spracovat a pripravit nahratie PDF faktury od dodavatela cez AgeVolt MCP. Klientske ponuky, predajne objednavky a klientske faktury ries cez superfaktura-client-side. Pri zapise vzdy najprv priprav preview a execute volaj az po explicitnom potvrdeni pouzivatela.
---

# SuperFaktura Supplier Side

Pouzivaj AgeVolt SuperFaktura MCP server `agevolt-superfaktura` a dodavatelsky relevantne `sf_*` nastroje.

## Najprv Nacitaj KB

Pri prvej praci so zapisom, zmazanim, sparovanim, nahratim PDF alebo nejasnym typom dodavatelskeho dokladu precitaj:

- `../../kb/superfaktura-supplier-documents.md`
- `../../kb/superfaktura-mcp.md`

Pri jednoduchom read-only dotaze mozes rovno pouzit nastroj.

## Scope

Tento skill je iba pre dodavatelsku stranu:

- dodavatelia alebo obchodni partneri,
- dodavatelske alebo nakupne objednavky,
- dodavatelske a nakladove faktury,
- dodavatelske dodacie listy alebo referencie na ne,
- sparovanie objednavky, dodacieho listu a nakladovej faktury,
- spracovanie PDF faktury od dodavatela.

Klientska strana patri do `superfaktura-client-side`: cenove ponuky, predajne objednavky, zalohove faktury, ostre faktury, klientske dodacie listy, odoslanie klientovi a uhrady klientskych dokladov.

## Rychla Cesta

- Dodavatelska objednavka pouziva `sf_documents_*` s `type=reverse_order`.
- Dodavatelska alebo nakladova faktura pouziva `sf_expenses_*`.
- Posledne nakladove faktury: `sf_expenses_list` s `per_page=N`, `page=1`, `sort=created`, `direction=DESC`.
- Detail nakladovej faktury: `sf_expenses_get` s presnym `id`.
- Dodaci list pouzi ako `type=delivery` len ked je jasne, ze ide o podporovany SuperFaktura doklad pre danu operaciu.
- Priame API `sf_api_write_preview` pouzi iba ked strukturovany tool nestaci a poznas presnu API cestu aj payload.

Pouzivaj priamo MCP tooly zo servera `agevolt-superfaktura`. Nevolaj SuperFaktura HTTP endpointy cez shell alebo iny fallback.

Ak MCP tooly `sf_documents_*` alebo `sf_expenses_*` nie su v aktualnom chate viditelne:

1. Najprv over, ci je MCP server zaregistrovany a prihlaseny.
2. Ak `agevolt-superfaktura` nema OAuth login, spusti alebo pouzivatelovi odporuc presny prikaz:

```text
codex mcp login agevolt-superfaktura --scopes MCP.Access
```

3. Po uspesnom prihlaseni ma `codex mcp list` ukazat `Auth OAuth`.
4. Potom treba otvorit novy chat alebo restartovat/refreshnut Codex, aby sa MCP tooly vystavili do aktualneho tool surface.

Prihlasenie moze prebehnut bez zadania hesla, ak je pouzivatel uz prihlaseny do MS365 v browseri. Stranka `Authentication complete` znamena uspesny OAuth callback.

## Bezpecny Zapis

Nikdy nevykonaj create/update/delete/sparovanie/nahratie PDF priamo.

1. Najdi alebo over presny ciel.
2. Zavolaj prislusny preview tool, napriklad `sf_documents_create_preview`, `sf_expenses_create_preview` alebo `sf_expenses_update_preview`.
3. V odpovedi ukaz pouzivatelovi co sa ide zmenit, cielovy zaznam, riziko a `confirmation_id`.
4. Execute tool zavolaj az po jasnom potvrdeni v aktualnej konverzacii.
5. Execute toolu posli iba `confirmation_id`.

Ak pouzivatel nepotvrdi explicitne, skonci previewom.

## PDF Faktura Od Dodavatela

Ked pouzivatel prida PDF fakturu od dodavatela:

1. Vytaz z PDF dodavatela, cislo faktury, variabilny symbol, datum vystavenia, datum dodania, splatnost, menu, sumy, DPH a polozky.
2. Over dodavatela a duplicitu faktury cez `sf_expenses_list` alebo vyhladanie partnera.
3. Priprav preview vytvorenia alebo upravy cez `sf_expenses_create_preview` alebo `sf_expenses_update_preview`.
4. Prilohu PDF nahravaj iba vtedy, ked aktualny MCP/API payload jasne podporuje prilohy alebo ked poznas presnu SuperFaktura API cestu; inak jasne povedz, ze samotne nahratie PDF vyzaduje doplnenie MCP alebo presny podporovany endpoint.

## Zakazy

- Nepouzivaj `type=order` pre dodavatelsku objednavku; pouzi `type=reverse_order`.
- Neries klientske ponuky, predajne objednavky, klientske faktury, odoslanie klientovi ani uhrady klientskych dokladov.
- Nevymyslaj dodavatela, sumy, DPH, splatnost, menu, polozky, cislo faktury ani vazbu na objednavku alebo dodaci list.
- Nepouzivaj stare tool nazvy ako `list_recent_documents`, `get_document`, `create_document`, `edit_document` alebo `convert_document`.
- Nekopiruj customer data, supplier data, realne faktury ani PDF subory do Git repozitara alebo markdown suborov.
- Nepouzivaj `sf_api_write` bez predchadzajuceho `sf_api_write_preview`.
- Neobchadzaj MCP priamym `Invoke-RestMethod`, `curl` alebo HTTP volanim na `/index.php/sf_*`.
