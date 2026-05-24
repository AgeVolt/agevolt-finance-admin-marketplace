# SuperFaktura MCP KB

## Endpointy

```text
https://documents.agevolt.com/mcp/superfaktura/
https://documents.agevolt.com/mcp/superfaktura/mcp
https://documents.agevolt.com/mcp/superfaktura/?openapi=1
```

Codex plugin pouziva MCP konfiguraciu:

```json
{
  "mcpServers": {
    "agevolt-superfaktura": {
      "type": "http",
      "url": "https://documents.agevolt.com/mcp/superfaktura/mcp"
    }
  }
}
```

Tieto endpointy su diagnostika a konfiguracia. Bezne tasky musia pouzivat priamo MCP tooly `sf_*` zo servera `agevolt-superfaktura`. Agent nema obchadzat MCP priamym HTTP volanim na `/index.php/sf_*`. Ak `sf_*` MCP tooly nie su v chate viditelne, treba riesit instalaciu, upgrade, refresh alebo restart Codexu.

## Tool Groups V Scope Tohto Pluginu

- `sf_meta_*` - status konektora a API.
- `sf_clients_*` - klienti alebo obchodni partneri, ak ich SuperFaktura pouziva aj pri dodavateloch.
- `sf_documents_*` - klientske doklady a dodavatelske objednavky.
- `sf_expenses_*` - dodavatelske alebo nakladove faktury.
- `sf_contact_persons_*` - kontaktne osoby, iba ak su potrebne pre konkretny doklad.
- `sf_value_lists_*` - dynamicke ciselniky, iba ak su potrebne pre doklad.
- `sf_api_get` - read-only detail partnera alebo dokladu, ked strukturovany tool nestaci.
- `sf_api_write_preview`, `sf_api_write` - iba pre operaciu bez strukturovaneho toolu a iba ked je znama presna API cesta aj payload.

Mimo scope aktualnej verzie: sklad, pokladna, vseobecne nastavenia SuperFaktury a akekolvek operacie, pri ktorych nie je jasny ciel alebo podporovany payload.

## Smoke Test

- `/health` vrati HTTP 200 a neukaze secrets.
- `/?openapi=1` obsahuje `sf_*` nastroje.
- MCP `tools/list` vrati SuperFaktura tool list.
- Read-only `sf_documents_list` s klientskym typom dokladu vrati data alebo korektnu SuperFaktura chybu.
- Read-only `sf_expenses_list` vrati data alebo korektnu SuperFaktura chybu.
- Preview tool, napriklad `sf_documents_create_preview`, vrati `preview_ready` a `confirmation_id` bez vykonania zapisu.
- Execute bez `confirmation_id` musi byt odmietnuty.
