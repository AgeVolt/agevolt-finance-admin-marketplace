param(
    [ValidateSet("last-invoice", "recent-invoices")]
    [string]$Preset = "last-invoice",
    [int]$Limit = 1,
    [ValidateSet("regular", "estimate", "order", "proforma", "delivery", "cancel")]
    [string]$Type = "regular",
    [switch]$Raw
)

$ErrorActionPreference = "Stop"

if ($Preset -eq "last-invoice") {
    $Limit = 1
}

$body = @{
    tool = "sf.documents.list"
    arguments = @{
        type = $Type
        per_page = $Limit
        page = 1
        sort = "created"
        direction = "DESC"
    }
} | ConvertTo-Json -Depth 10 -Compress

$response = Invoke-RestMethod `
    -Uri "https://documents.agevolt.com/mcp/superfaktura/" `
    -Method Post `
    -ContentType "application/json" `
    -Body $body

if ($Raw) {
    $response | ConvertTo-Json -Depth 20
    exit 0
}

if (-not $response.ok) {
    throw ($response.error.message ?? "SuperFaktura request failed.")
}

@($response.result.documents) | Select-Object `
    id,
    number,
    client_name,
    client_ico,
    created,
    delivery,
    due,
    currency,
    amount,
    total_amount,
    paid,
    flag |
    ConvertTo-Json -Depth 10
