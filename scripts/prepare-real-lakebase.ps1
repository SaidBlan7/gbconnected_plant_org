$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$backend = Join-Path $root 'backend'
$target = Join-Path $backend 'src\main\resources\local.settings.json'
$source = Join-Path $backend 'src\main\resources\local.settings.lakebase.example.json'

if (Test-Path $target) {
    $backup = "$target.backup-$(Get-Date -Format yyyyMMdd-HHmmss)"
    Copy-Item $target $backup
    Write-Host "Backup creado: $backup"
}

Copy-Item $source $target -Force
Write-Host 'Copiado local.settings.lakebase.example.json -> local.settings.json'
Write-Host 'AHORA edita local.settings.json y rellena DATABRICKS_* y LAKEBASE_DATA_API_URL.'
