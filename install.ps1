# ============================================================
# MCP Database Server — Instalador para Windows
# Uso: .\install.ps1
# ============================================================

Write-Host "🗄️  MCP Database Server Setup" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Verificar Node.js
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js $nodeVersion encontrado" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js no encontrado. Descárgalo de https://nodejs.org" -ForegroundColor Red
    exit 1
}

# Instalar el paquete
Write-Host ""
Write-Host "📦 Instalando @nam088/mcp-database-server..." -ForegroundColor Yellow
npm install -g @nam088/mcp-database-server
Write-Host "✅ Servidor instalado" -ForegroundColor Green

# Configuración
Write-Host ""
Write-Host "🔧 Configuración" -ForegroundColor Cyan
$dbType = Read-Host "Tipo de DB [postgres/mongodb/redis] (default: postgres)"
if ([string]::IsNullOrEmpty($dbType)) { $dbType = "postgres" }

$connStr = Read-Host "Connection string"

$readOnly = "true"
if ($dbType -eq "redis") { $readOnly = "false" }

$config = @{
    mcpServers = @{
        "mcp-database" = @{
            command = "npx"
            args = @("-y", "@nam088/mcp-database-server")
            env = @{
                DB_TYPE = $dbType
                "$($dbType.ToUpper())_CONNECTION_STRING" = $connStr
                READ_ONLY_MODE = $readOnly
            }
        }
    }
} | ConvertTo-Json -Depth 10

# Guardar
$mcpDir = "$env:USERPROFILE\.mcp"
New-Item -ItemType Directory -Force -Path $mcpDir | Out-Null
$config | Out-File -FilePath "$mcpDir\mcp-database-config.json" -Encoding utf8

Write-Host ""
Write-Host "✅ Config guardada en $mcpDir\mcp-database-config.json" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Copia este JSON en LobeChat Desktop:" -ForegroundColor Cyan
Write-Host "  Settings → Default Agent → Plugin Settings → Quick Import JSON" -ForegroundColor White
Write-Host ""
Write-Host $config
Write-Host ""
Write-Host "🎉 ¡Listo!" -ForegroundColor Green
