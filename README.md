# 🗄️ MCP Database Server Setup

Instalación automática del servidor MCP `@nam088/mcp-database-server` para LobeChat Desktop.

Soporta: **PostgreSQL / Supabase · MongoDB · Redis · LDAP**

---

## ⚡ Instalación rápida en LobeChat Desktop

1. Abre **LobeChat Desktop**
2. Ve a `Settings → Default Agent → Plugin Settings → Custom Plugins`
3. Haz clic en **Quick Import JSON Configuration**
4. Copia el JSON de la carpeta `configs/` según tu base de datos

---

## 📁 Archivos

| Archivo | Descripción |
|---|---|
| `configs/supabase-postgres.json` | Configuración para Supabase/PostgreSQL |
| `configs/mongodb.json` | Configuración para MongoDB |
| `configs/redis.json` | Configuración para Redis |
| `configs/multi-db.json` | Múltiples bases de datos al mismo tiempo |
| `install.sh` | Script bash para Linux/Mac/Codespaces |
| `install.ps1` | Script PowerShell para Windows |

---

## 🔧 Variables de entorno necesarias

### PostgreSQL / Supabase
```env
DB_TYPE=postgres
POSTGRES_CONNECTION_STRING=postgresql://user:password@host:5432/database
READ_ONLY_MODE=true
```

### MongoDB
```env
DB_TYPE=mongodb
MONGODB_CONNECTION_STRING=mongodb://localhost:27017/mydb
READ_ONLY_MODE=true
```

### Redis
```env
DB_TYPE=redis
REDIS_CONNECTION_STRING=redis://localhost:6379
READ_ONLY_MODE=false
```

---

## 🚀 Para EstacionKusFM (Supabase)

Reemplaza en `configs/supabase-postgres.json`:
- `YOUR_SUPABASE_DB_PASSWORD` → tu contraseña de Supabase
- `YOUR_PROJECT_REF` → el ID de tu proyecto Supabase (ej: `abcdefghijklmnop`)

La cadena de conexión de Supabase tiene este formato:
```
postgresql://postgres.YOUR_PROJECT_REF:YOUR_PASSWORD@aws-0-us-east-1.pooler.supabase.com:6543/postgres
```

---

## 🛡️ Modo Solo Lectura

Por defecto `READ_ONLY_MODE=true`. Para habilitar escritura:
```json
"READ_ONLY_MODE": "false"
```

---

## 📱 Uso desde celular

Configura el servidor desde tu Codespace (GitHub Codespaces) y accede a LobeChat desde el navegador móvil en [chat.lobehub.com](https://chat.lobehub.com).
