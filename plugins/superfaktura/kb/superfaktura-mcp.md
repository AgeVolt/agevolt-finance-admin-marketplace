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

## Tool Groups V Scope Tohto Pluginu

- `sf.meta.*` - status konektora a API.
- `sf.clients.*` - klienti alebo obchodni partneri, ak ich SuperFaktura pouziva aj pri dodavateloch.
- `sf.documents.*` - klientske doklady a dodavatelske objednavky.
- `sf.expenses.*` - dodavatelske alebo nakladove faktury.
- `sf.contact_persons.*` - kontaktne osoby, iba ak su potrebne pre konkretny doklad.
- `sf.value_lists.*` - dynamicke ciselniky, iba ak su potrebne pre doklad.
- `sf.api.get` - read-only detail partnera alebo dokladu, ked strukturovany tool nestaci.
- `sf.api.write_preview`, `sf.api.write` - iba pre operaciu bez strukturovaneho toolu a iba ked je znama presna API cesta aj payload.

Mimo scope aktualnej verzie: sklad, pokladna, vseobecne nastavenia SuperFaktury a akekolvek operacie, pri ktorych nie je jasny ciel alebo podporovany payload.

## Smoke Test

- `/health` vrati HTTP 200 a neukaze secrets.
- `/?openapi=1` obsahuje `sf.*` nastroje.
- MCP `tools/list` vrati SuperFaktura tool list.
- Read-only `sf.documents.list` s klientskym typom dokladu vrati data alebo korektnu SuperFaktura chybu.
- Read-only `sf.expenses.list` vrati data alebo korektnu SuperFaktura chybu.
- Preview tool, napriklad `sf.documents.create_preview`, vrati `preview_ready` a `confirmation_id` bez vykonania zapisu.
- Execute bez `confirmation_id` musi byt odmietnuty.
