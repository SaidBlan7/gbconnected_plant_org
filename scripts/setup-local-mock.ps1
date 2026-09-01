$ErrorActionPreference = 'Stop'

Write-Host '=== GB Connected - setup local mock ==='

$root = Split-Path -Parent $PSScriptRoot
$backend = Join-Path $root 'backend'
$frontend = Join-Path $root 'frontend'

$settings = Join-Path $backend 'src\main\resources\local.settings.json'
$example = Join-Path $backend 'src\main\resources\local.settings.example.json'

if (-not (Test-Path $settings)) {
    Copy-Item $example $settings
    Write-Host 'Creado backend/src/main/resources/local.settings.json'
} else {
    Write-Host 'local.settings.json ya existe; no se sobrescribió.'
}

Write-Host ''
Write-Host 'Instalando dependencias Angular...'
Push-Location $frontend
npm install
Pop-Location

Write-Host ''
Write-Host 'Listo. Ahora abre 2 terminales:'
Write-Host '1) scripts/run-backend.ps1'
Write-Host '2) scripts/run-frontend.ps1'
