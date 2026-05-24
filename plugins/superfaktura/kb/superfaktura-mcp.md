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
- `sf.clients.*` - klienti.
- `sf.documents.*` - klientske ponuky, objednavky, zalohove faktury, ostre faktury, dodacie listy a storna.
- `sf.contact_persons.*` - kontaktne osoby klientov, iba ak su potrebne pre klientsky doklad.
- `sf.value_lists.*` - dynamicke ciselniky, iba ak su potrebne pre klientsky doklad.
- `sf.api.get` - read-only detail klienta alebo dokladu, ked strukturovany tool nestaci.
- `sf.api.write_preview`, `sf.api.write` - iba pre klientsku operaciu bez strukturovaneho toolu.

Mimo scope prvej verzie: `sf.expenses.*`, `sf.stock.*`, `sf.cash_registers.*`, `sf.cash_register_items.*`, nakupne/dodavatelske objednavky, sklad a pokladna.

## Smoke Test

- `/health` vrati HTTP 200 a neukaze secrets.
- `/?openapi=1` obsahuje `sf.*` nastroje.
- MCP `tools/list` vrati SuperFaktura tool list.
- Read-only `sf.documents.list` s klientskym typom dokladu vrati data alebo korektnu SuperFaktura chybu.
- Preview tool, napriklad `sf.documents.create_preview`, vrati `preview_ready` a `confirmation_id` bez vykonania zapisu.
- Execute bez `confirmation_id` musi byt odmietnuty.
