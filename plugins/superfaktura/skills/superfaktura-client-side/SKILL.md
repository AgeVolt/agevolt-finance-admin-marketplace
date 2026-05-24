---
name: superfaktura-client-side
description: Pouzi pri klientskej praci so SuperFakturou v AgeVolt, najma ked treba citat klientov alebo klientske doklady, vytvorit, upravit, zmazat, odoslat alebo uhradit cenovu ponuku, predajnu objednavku, zalohovu fakturu, ostru fakturu alebo dodaci list cez AgeVolt MCP. Neries nakupne objednavky, naklady, sklad, pokladnu ani ine casti SuperFaktury. Pri zapise vzdy najprv priprav preview a execute volaj az po explicitnom potvrdeni pouzivatela.
---

# SuperFaktura Client Side

Pouzivaj AgeVolt SuperFaktura MCP server `agevolt-superfaktura` a iba klientsky relevantne `sf_*` nastroje.

## Najprv Nacitaj KB

Pri prvej praci so zapisom, zmazanim, odoslanim, uhradou alebo nejasnym typom klientskeho dokladu precitaj:

- `../../kb/superfaktura-client-documents.md`
- `../../kb/superfaktura-mcp.md`

Pri jednoduchom read-only dotaze mozes rovno pouzit nastroj.

## Scope

Tento skill je iba pre klientsku stranu:

- klienti,
- cenove ponuky,
- predajne objednavky,
- zalohove faktury,
- ostre faktury,
- dodacie listy,
- odoslanie dokladu klientovi,
- uhrady klientskych dokladov.

Mimo scope: nakupne objednavky, dodavatelske faktury, naklady, sklad, pokladna, tagy a vseobecne nastavenia SuperFaktury.

## Rychla Cesta

- Posledna ostra faktura: `sf_documents_list` s `type=regular`, `per_page=1`, `page=1`, `sort=created`, `direction=DESC`.
- Poslednych N faktur: rovnake volanie s `per_page=N`.
- Cenove ponuky pouzivaju `type=estimate`.
- Predajne objednavky voci klientovi pouzivaju `type=order`.
- Zalohove faktury pouzivaju `type=proforma`.
- Ostre faktury pouzivaju `type=regular`.
- Dodacie listy pouzivaju `type=delivery`.
- Nepouzivaj `type=reverse_order`.

Pouzivaj priamo MCP tooly zo servera `agevolt-superfaktura`. Nevolaj SuperFaktura HTTP endpointy cez shell alebo iny fallback.

Ak MCP tooly `sf_documents_*` nie su v aktualnom chate viditelne:

1. Najprv over, ci je MCP server zaregistrovany a prihlaseny.
2. Ak `agevolt-superfaktura` nema OAuth login, spusti alebo pouzivatelovi odporuc presny prikaz:

```text
codex mcp login agevolt-superfaktura --scopes MCP.Access
```

3. Po uspesnom prihlaseni ma `codex mcp list` ukazat `Auth OAuth`.
4. Potom treba otvorit novy chat alebo restartovat/refreshnut Codex, aby sa MCP tooly vystavili do aktualneho tool surface.

Prihlasenie moze prebehnut bez zadania hesla, ak je pouzivatel uz prihlaseny do MS365 v browseri. Stranka `Authentication complete` znamena uspesny OAuth callback.

## Bezpecny Zapis

Nikdy nevykonaj create/update/delete/send/payment priamo.

1. Najdi alebo over presny ciel.
2. Zavolaj prislusny preview tool, napriklad `sf_documents_create_preview`, `sf_documents_update_preview` alebo `sf_documents_delete_preview`.
3. V odpovedi ukaz pouzivatelovi co sa ide zmenit, cielovy zaznam, riziko a `confirmation_id`.
4. Execute tool zavolaj az po jasnom potvrdeni v aktualnej konverzacii.
5. Execute toolu posli iba `confirmation_id`.

Ak pouzivatel nepotvrdi explicitne, skonci previewom.

## Zakazy

- Nevymyslaj ceny, DPH, splatnost, menu, klienta ani polozky.
- Neries nakupne objednavky, dodavatelske faktury, naklady, sklad, pokladnu ani interne SuperFaktura nastavenia.
- Nepouzivaj stare tool nazvy ako `list_recent_documents`, `get_document`, `create_document`, `edit_document` alebo `convert_document`.
- Nekopiruj customer data ani realne doklady do Git repozitara alebo markdown suborov.
- Nepouzivaj `sf_api_write` bez predchadzajuceho `sf_api_write_preview`.
- Neobchadzaj MCP priamym `Invoke-RestMethod`, `curl` alebo HTTP volanim na `/index.php/sf_*`.
