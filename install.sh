#!/bin/bash
# ============================================================
# MCP Database Server — Instalador automático
# Compatible con: Linux, macOS, GitHub Codespaces
# Uso: bash install.sh
# ============================================================

set -e

echo "🗄️  MCP Database Server Setup"
echo "================================"

# Verificar Node.js
if ! command -v node &> /dev/null; then
  echo "❌ Node.js no encontrado. Instalando..."
  curl -fsSL https://fnm.vercel.app/install | bash
  source ~/.bashrc
  fnm install --lts
else
  echo "✅ Node.js $(node -v) encontrado"
fi

# Verificar npx
if ! command -v npx &> /dev/null; then
  echo "❌ npx no encontrado. Instala npm."
  exit 1
else
  echo "✅ npx encontrado"
fi

# Instalar el paquete globalmente (opcional, para uso offline)
echo ""
echo "📦 Instalando @nam088/mcp-database-server..."
npm install -g @nam088/mcp-database-server
echo "✅ Servidor instalado correctamente"

# Crear directorio de configs si no existe
mkdir -p ~/.mcp

echo ""
echo "🔧 Configuración de conexión"
echo "----------------------------"
read -p "Tipo de DB [postgres/mongodb/redis] (default: postgres): " DB_TYPE
DB_TYPE=${DB_TYPE:-postgres}

case $DB_TYPE in
  postgres)
    read -p "Connection string PostgreSQL: " CONN_STR
    CONFIG="{\"mcpServers\":{\"mcp-database\":{\"command\":\"npx\",\"args\":[\"-y\",\"@nam088/mcp-database-server\"],\"env\":{\"DB_TYPE\":\"postgres\",\"POSTGRES_CONNECTION_STRING\":\"$CONN_STR\",\"READ_ONLY_MODE\":\"true\"}}}}"
    ;;
  mongodb)
    read -p "Connection string MongoDB: " CONN_STR
    CONFIG="{\"mcpServers\":{\"mcp-database\":{\"command\":\"npx\",\"args\":[\"-y\",\"@nam088/mcp-database-server\"],\"env\":{\"DB_TYPE\":\"mongodb\",\"MONGODB_CONNECTION_STRING\":\"$CONN_STR\",\"READ_ONLY_MODE\":\"true\"}}}}"
    ;;
  redis)
    read -p "Connection string Redis: " CONN_STR
    CONFIG="{\"mcpServers\":{\"mcp-database\":{\"command\":\"npx\",\"args\":[\"-y\",\"@nam088/mcp-database-server\"],\"env\":{\"DB_TYPE\":\"redis\",\"REDIS_CONNECTION_STRING\":\"$CONN_STR\",\"READ_ONLY_MODE\":\"false\"}}}}"
    ;;
  *)
    echo "❌ Tipo de DB no válido"
    exit 1
    ;;
esac

# Guardar config
echo $CONFIG > ~/.mcp/mcp-database-config.json
echo ""
echo "✅ Config guardada en ~/.mcp/mcp-database-config.json"
echo ""
echo "📋 Copia este JSON en LobeChat Desktop:"
echo "  Settings → Default Agent → Plugin Settings → Quick Import JSON"
echo ""
cat ~/.mcp/mcp-database-config.json
echo ""
echo "🎉 ¡Listo! Importa el JSON en LobeChat y activa el plugin."
