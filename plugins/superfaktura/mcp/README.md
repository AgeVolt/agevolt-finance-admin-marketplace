# SuperFaktura MCP

Tento plugin pouziva uz nasadeny AgeVolt SuperFaktura MCP server:

```text
https://documents.agevolt.com/mcp/superfaktura/mcp
```

Aktivna Codex konfiguracia je v `.mcp.json`. Plugin pouziva oddelene skilly pre klientsku a dodavatelsku cast, ale stale jeden MCP server `agevolt-superfaktura`.

Agent ma volat priamo MCP tooly `sf_*`. Priame HTTP volania na `/index.php/sf_*` su iba diagnostika pocas vyvoja servera, nie bezny fallback pre pouzivatelske tasky.

Do Git marketplace nepatria SuperFaktura tokeny, FTP pristupy, customer data, supplier data, realne PDF faktury ani lokalny `config.local.php`.

Prevadzkovy PHP server code je ulozeny iba v internom SharePointe:

```text
AI Agent/marketplaces/agevolt-finance-admin-marketplace/plugins/superfaktura/mcp/server_code/
```

Spolocne WebSupport pristupy su v Creator skill `mcp-websupport` ako SharePoint-only private reference, nie v public Git repozitari.
