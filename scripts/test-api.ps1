$ErrorActionPreference = 'Stop'
$base = 'http://localhost:7071/api'

Write-Host '=== WHOAMI ==='
Invoke-RestMethod "$base/debug/whoami" | ConvertTo-Json -Depth 10

Write-Host '\n=== HEALTH ==='
Invoke-RestMethod "$base/health/lakebase" | ConvertTo-Json -Depth 10

Write-Host '\n=== ORGANIZACIONES ==='
Invoke-RestMethod "$base/me/organizations" | ConvertTo-Json -Depth 10

Write-Host '\n=== PLANTAS MEXICO ==='
Invoke-RestMethod "$base/me/organizations/org-mx/plants" | ConvertTo-Json -Depth 10

Write-Host '\n=== INTENTO USA (debe ser []) ==='
Invoke-RestMethod "$base/me/organizations/org-us/plants" | ConvertTo-Json -Depth 10
