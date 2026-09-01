$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$backend = Join-Path $root 'backend'

Set-Location $backend

Write-Host ""
Write-Host "=========================================="
Write-Host "Compilando backend"
Write-Host "=========================================="
Write-Host ""

.\mvnw.cmd clean package

if ($LASTEXITCODE -ne 0) {
    throw "Error compilando el backend."
}

Write-Host ""
Write-Host "=========================================="
Write-Host "Iniciando Azure Functions"
Write-Host "=========================================="
Write-Host ""

.\mvnw.cmd azure-functions:run