# SuperFaktura MCP

Tento plugin pouziva uz nasadeny AgeVolt SuperFaktura MCP server:

```text
https://documents.agevolt.com/mcp/superfaktura/mcp
```

Aktivna Codex konfiguracia je v `.mcp.json`. Plugin pouziva oddelene skilly pre klientsku a dodavatelsku cast, ale stale jeden MCP server `agevolt-superfaktura`.

Agent ma volat priamo MCP tooly `sf_*`. Priame HTTP volania na `/index.php/sf_*` su iba diagnostika pocas vyvoja servera, nie bezny fallback pre pouzivatelske tasky.

Do Git marketplace nepatria SuperFaktura tokeny, FTP pristupy, customer data, supplier data, realne PDF faktury ani lokalny `config.local.php`.

Zdrojovy PHP server zo stareho `AI/Doplnky/mcp/superfaktura` nebol skopirovany do tohto prveho kroku, aby sme nepreniesli secrets alebo prevadzkovy neporiadok. Migracia serveroveho zdrojaku ma byt samostatny krok s kontrolou secretov.
