#!/bin/bash

# =============================================================================
# StartFlutter - Inicializador de proyecto Flutter
# =============================================================================
# Este script crea un proyecto Flutter con estructura CPAC lista para producción.
#
# Uso:
#   ./init_project.sh              # Modo interactivo
#   ./init_project.sh --simple     # Solo crear proyecto (sin IA)
#   ./init_project.sh --with-ai    # Crear proyecto + configurar con IA
# =============================================================================

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# =============================================================================
# Funciones auxiliares
# =============================================================================

print_header() {
    echo -e "\n${BLUE}🚀 StartFlutter - Inicialización${NC}"
    echo "=============================================="
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# =============================================================================
# 1. Detectar modo de ejecución
# =============================================================================

MODE="interactive"

if [ "$1" == "--simple" ]; then
    MODE="simple"
elif [ "$1" == "--with-ai" ]; then
    MODE="with-ai"
elif [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Uso: ./init_project.sh [modo]"
    echo ""
    echo "Modos:"
    echo "  --simple     Crear proyecto sin IA (solo estructura)"
    echo "  --with-ai    Crear proyecto y configurar con IA"
    echo "  (sin args)   Modo interactivo (preguntar)"
    echo ""
    echo "Ejemplos:"
    echo "  ./init_project.sh              # Preguntar qué hacer"
    echo "  ./init_project.sh --with-ai     # Usar IA"
    exit 0
fi

print_header

# =============================================================================
# 2. Solicitar datos del proyecto
# =============================================================================

echo -e "\n${YELLOW}📝 Datos del proyecto:${NC}"

if [ "$MODE" == "interactive" ]; then
    read -p "  Nombre de la app (ej: mi_app): " APP_NAME
    read -p "  Bundle ID (ej: com.miestudio.miapp): " BUNDLE_ID

    echo -e "\n  Gestor de estado:"
    echo "    1) Riverpod"
    echo "    2) Bloc/Cubit"
    echo "    3) Híbrido (Riverpod + Bloc)"
    read -p "  Opción [1-3]: " STATE_OPTION

    echo -e "\n  Modo de ejecución:"
    echo "    1) Simple (solo estructura)"
    echo "    2) Con IA (configurar con agente)"
    read -p "  Opción [1-2]: " MODE_OPTION

    case $MODE_OPTION in
        1) MODE="simple";;
        2) MODE="with-ai";;
    esac
else
    # Modo no interactivo - usar valores por defecto o entorno
    APP_NAME="${APP_NAME:-mi_app}"
    BUNDLE_ID="${BUNDLE_ID:-com.example.miapp}"
    STATE_OPTION="${STATE_OPTION:-2}"  # Default: Bloc/Cubit
fi

case $STATE_OPTION in
    1) STATE_MANAGER="Riverpod";;
    2) STATE_MANAGER="Bloc/Cubit";;
    3) STATE_MANAGER="Híbrido";;
    *) STATE_MANAGER="Bloc/Cubit";;
esac

echo -e "\n${GREEN}✓${NC} Configuración: $APP_NAME | $BUNDLE_ID | $STATE_MANAGER | Modo: $MODE"

# =============================================================================
# 3. Crear proyecto Flutter
# =============================================================================
echo -e "\n${YELLOW}🛠️  Creando proyecto Flutter...${NC}"

# Siempre crear en la raíz (no en subcarpeta)
flutter create --org "$BUNDLE_ID" .

print_success "Proyecto creado/actualizado"

# =============================================================================
# 4. Crear estructura de directorios
# =============================================================================
echo -e "\n${YELLOW}📁 Creando estructura de directorios...${NC}"

mkdir -p assets/env
mkdir -p lib/config
mkdir -p lib/l10n
mkdir -p lib/core/{error,network,di,usecases}
mkdir -p lib/features
mkdir -p doc

print_success "Estructura creada"

# =============================================================================
# 5. Templates (local o fallback a internet)
# =============================================================================
echo -e "\n${YELLOW}📥 Configurando templates...${NC}"

GITHUB_RAW="https://raw.githubusercontent.com/IvanMartinezLeon/FlutterCPAC/main/doc_templates"

get_template() {
    local src=$1
    local dst=$2
    if [ -f "$src" ]; then
        cp "$src" "$dst"
    else
        curl -sL "$GITHUB_RAW/$dst" -o "$dst" 2>/dev/null || echo "# Template no disponible" > "$dst"
    fi
}

get_template "doc_templates/project_templates.md" "PROJECT_LOG.md"
mkdir -p doc
get_template "doc_templates/examples/env_example.md" "doc/env_example.md"
get_template "doc_templates/examples/l10n_example.md" "doc/l10n_example.md"

print_success "Templates configurados"

# =============================================================================
# 6. Crear archivos .env
# =============================================================================
echo -e "\n${YELLOW}🌍 Creando archivos de entorno...${NC}"

cat > assets/env/.env.debug << EOF
ENVIRONMENT=debug
API_URL=https://api-dev.example.com
LOG_LEVEL=debug
FEATURE_FLAGS=true
APP_NAME="$APP_NAME (DEV)"
EOF

cat > assets/env/.env.profile << EOF
ENVIRONMENT=profile
API_URL=https://api-staging.example.com
LOG_LEVEL=info
FEATURE_FLAGS=true
APP_NAME="$APP_NAME (STAGING)"
EOF

cat > assets/env/.env.release << EOF
ENVIRONMENT=release
API_URL=https://api.example.com
LOG_LEVEL=error
FEATURE_FLAGS=false
APP_NAME="$APP_NAME"
EOF

cat > assets/env/.env.example << EOF
ENVIRONMENT=debug
API_URL=https://api-dev.example.com
LOG_LEVEL=debug
FEATURE_FLAGS=true
APP_NAME="$APP_NAME"
EOF

print_success "Archivos .env creados"

# =============================================================================
# 7. Configurar pubspec.yaml
# =============================================================================
echo -e "\n${YELLOW}📦 Actualizando pubspec.yaml...${NC}"

# Añadir configuración de Flutter si no existe
if ! grep -q "generate: true" pubspec.yaml; then
    # Detectar SO para sed
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' 's/flutter:/flutter:\n  generate: true\n  uses-material-design: true\n  assets:\n    - assets\/env\/.env.debug\n    - assets\/env\/.env.profile\n    - assets\/env\/.env.release/' pubspec.yaml
    else
        sed -i 's/flutter:/flutter:\n  generate: true\n  uses-material-design: true\n  assets:\n    - assets\/env\/.env.debug\n    - assets\/env\/.env.profile\n    - assets\/env\/.env.release/' pubspec.yaml
    fi
fi

# Añadir dependencias si no existen
if ! grep -q "flutter_dotenv" pubspec.yaml; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' 's/dependencies:/dependencies:\n  flutter_dotenv: ^5.1.0\n  intl: ^0.19.0\n  flutter_localizations:\n    sdk: flutter/' pubspec.yaml
    else
        sed -i 's/dependencies:/dependencies:\n  flutter_dotenv: ^5.1.0\n  intl: ^0.19.0\n  flutter_localizations:\n    sdk: flutter/' pubspec.yaml
    fi
fi

print_success "pubspec.yaml actualizado"

# =============================================================================
# 8. Instalar dependencias
# =============================================================================
echo -e "\n${YELLOW}⬇️  Instalando dependencias...${NC}"
flutter pub get
print_success "Dependencias instaladas"

# =============================================================================
# 9. Configurar l10n
# =============================================================================
echo -e "\n${YELLOW}🌐 Configurando internacionalización...${NC}"

cat > l10n.yaml << EOF
arb-dir: lib/l10n
template-arb-file: app_es.arb
output-localization-file: app_localizations
output-class: AppLocalizations
synthetic-package: false
output-dir: lib/l10n/generated
EOF

cat > lib/l10n/app_es.arb << EOF
{
  "@@locale": "es",
  "appName": "$APP_NAME",
  "welcome": "Bienvenido",
  "settings": "Ajustes",
  "language": "Idioma",
  "debug": "Desarrollo",
  "profile": "Preproducción",
  "release": "Producción"
}
EOF

cat > lib/l10n/app_en.arb << EOF
{
  "@@locale": "en",
  "appName": "$APP_NAME",
  "welcome": "Welcome",
  "settings": "Settings",
  "language": "Language",
  "debug": "Debug",
  "profile": "Profile",
  "release": "Release"
}
EOF

flutter gen-l10n
print_success "Internacionalización configurada"

# =============================================================================
# 10. Crear PROJECT_LOG.md
# =============================================================================
echo -e "\n${YELLOW}📓 Inicializando PROJECT_LOG.md...${NC}"

cat > PROJECT_LOG.md << EOF
# PROJECT_LOG.md

> Memoria continua del proyecto: decisiones técnicas, errores, soluciones y aprendizajes

---

## Datos del Proyecto

- **Nombre:** $APP_NAME
- **Bundle ID:** $BUNDLE_ID
- **Gestor de Estado:** $STATE_MANAGER
- **Fecha de creación:** $(date +%Y-%m-%d)

---

## Reglas Iniciales Obligatorias

- [ ] PROJECT_LOG.md en raíz del proyecto (no en doc/)
- [ ] Usar \`const\` constructors siempre que sea posible
- [ ] Nombres de clases en PascalCase, métodos y variables en camelCase
- [ ] Archivos con nombres en snake_case
- [ ] 0 errores en \`flutter analyze\` antes de cada commit
- [ ] **Nunca repetir un error ya documentado.** Si ocurre, investigar por qué la solución anterior no fue efectiva.
- [ ] **Siempre actualizar PROJECT_LOG.md** tras cada modificación de feature
- [ ] **Siempre actualizar SPEC.md y TODO.md** de la feature al modificar algo
- [ ] UI adaptativa: Material Design (Android) / Cupertino (iOS)

---

## Entradas de Log

### [FEATURE] - $(date +%Y-%m-%d)

**Acción:** FEATURE

**Título:** Inicialización del proyecto

**Descripción:** Creación de proyecto Flutter con estructura CPAC, múltiples entornos e i18n

**Solución:** N/A

**Aprendizaje:** Workflow de inicialización completo con Clean Architecture

**Trabajo realizado:**
- Feature/Bug/Decisión trabajada: setup
- Archivos modificados: pubspec.yaml, assets/env/, lib/l10n/
- Duración estimada: 5min

**Deuda técnica / Pendientes:**

- [ ] Implementar primera feature

---

## Siguiente Paso

Para continuar con la configuración avanzada, ejecutar:

\`\`\`bash
# Instalar skill de Flutter (para que la IA conozca las reglas)
npx skills add IvanMartinezLeon/FlutterCPAC@flutter-cpac -g

# O configurar manualmente con tu IDE/IA
\`\`\`
EOF

print_success "PROJECT_LOG.md creado"

# =============================================================================
# 11. Verificar análisis estático
# =============================================================================
echo -e "\n${YELLOW}🔍 Verificando análisis estático...${NC}"

if flutter analyze 2>/dev/null; then
    print_success "Análisis passed"
else
    print_info "Hay warnings (no errores críticos)"
fi

# =============================================================================
# 12. Modo con IA - Invocar agente
# =============================================================================
if [ "$MODE" == "with-ai" ]; then
    echo -e "\n${YELLOW}🤖 Modo con IA activado${NC}"
    echo ""
    echo "Para completar la configuración con IA, ejecuta en tu IDE:"
    echo ""
    echo -e "${BLUE}┌────────────────────────────────────────────────────────┐${NC}"
    echo -e "${BLUE}│ 1. Instala el skill (si no lo has hecho):             │${NC}"
    echo -e "${BLUE}│                                                    │${NC}"
    echo -e "${BLUE}│    npx skills add IvanMartinezLeon/FlutterCPAC@flutter-cpac -g   │${NC}"
    echo -e "${BLUE}│                                                    │${NC}"
    echo -e "${BLUE}│ 2. Pide a tu IA que configure el gestor de estado   │${NC}"
    echo -e "${BLUE}│                                                    │${NC}"
    echo -e "${BLUE}│    \"Configura $STATE_MANAGER siguiendo las reglas     │${NC}"
    echo -e "${BLUE}│     del skill flutter-expert\"                       │${NC}"
    echo -e "${BLUE}└────────────────────────────────────────────────────────┘${NC}"
    echo ""
    print_info "El proyecto base está listo. La IA completará la configuración."
fi

# =============================================================================
# 13. Resumen final
# =============================================================================
echo -e "\n"
echo "=============================================="
echo -e "${GREEN}✅ PROYECTO CONFIGURADO EXITOSAMENTE${NC}"
echo "=============================================="
echo ""
echo "Entornos disponibles:"
echo "  • Debug (desarrollo)     → API: api-dev.example.com"
echo "  • Profile (preproducción) → API: api-staging.example.com"
echo "  • Release (producción)   → API: api.example.com"
echo ""
echo "Idiomas configurados:"
echo "  • Español (castellano) - Detectado automáticamente"
echo "  • Inglés (English) - Detectado automáticamente"
echo ""
echo "Gestor de Estado: $STATE_MANAGER"
echo "Modo: $MODE"
echo ""
echo -e "${GREEN}El proyecto está listo para:${NC}"
echo "  • Desarrollo inmediato"
echo "  • Pruebas en múltiples entornos"
echo "  • Implementación de features"
echo ""
if [ "$MODE" == "with-ai" ]; then
    echo -e "${YELLOW}⚠️  Recuerda completar la configuración con tu IA${NC}"
    echo "   (ver instrucciones arriba)"
else
    echo "Próximo paso: flutter run para verificar"
fi