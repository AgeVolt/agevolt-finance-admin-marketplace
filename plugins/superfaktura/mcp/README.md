# SuperFaktura MCP

Tento plugin pouziva uz nasadeny AgeVolt SuperFaktura MCP server, ale skill v prvej verzii pouziva iba klientsku cast SuperFaktury:

```text
https://documents.agevolt.com/mcp/superfaktura/mcp
```

Aktivna Codex konfiguracia je v `.mcp.json`. Do Git marketplace nepatria SuperFaktura tokeny, FTP pristupy, customer data ani lokalny `config.local.php`.

Zdrojovy PHP server zo stareho `AI/Doplnky/mcp/superfaktura` nebol skopirovany do tohto prveho kroku, aby sme nepreniesli secrets alebo prevadzkovy neporiadok. Migracia serveroveho zdrojaku ma byt samostatny krok s kontrolou secretov.
