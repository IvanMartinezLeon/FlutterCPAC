#!/bin/bash
#===============================================================================
# FlutterCPAC Changelog Generator
# Genera CHANGELOG.md desde doc/reports/
#===============================================================================

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuración
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="${SCRIPT_DIR}/../../.."
DOCS_DIR="${PROJECT_ROOT}/doc"
REPORTS_DIR="${DOCS_DIR}/reports"
TODAY=$(date +%Y_%m_%d)
VERSION="${1:-1.0.0}"

#-------------------------------------------------------------------------------
# Funciones
#-------------------------------------------------------------------------------

print_header() {
    echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

#-------------------------------------------------------------------------------
# Recopilar cambios desde logs
#-------------------------------------------------------------------------------

collect_features() {
    echo "Buscando cambios FEATURE en logs..."

    grep -h "**Acción:** FEATURE" "${REPORTS_DIR}"/log_report_*.md 2>/dev/null | \
        grep -oP '(?<=\*\*Título:\*\* ).+' | \
        sort -u || echo ""
}

collect_bugs() {
    echo "Buscando cambios BUG en logs..."

    grep -h "**Acción:** BUG" "${REPORTS_DIR}"/log_report_*.md 2>/dev/null | \
        grep -oP '(?<=\*\*Título:\*\* ).+' | \
        sort -u || echo ""
}

collect_audits() {
    echo "Buscando auditorías en logs..."

    grep -h "**Acción:** AUDIT" "${REPORTS_DIR}"/log_report_*.md 2>/dev/null | \
        grep -oP '(?<=\*\*Título:\*\* ).+' | \
        sort -u || echo ""
}

collect_tests() {
    echo "Buscando ejecuciones de tests..."

    grep -h "**Acción:** TEST" "${REPORTS_DIR}"/log_report_*.md 2>/dev/null | \
        grep -oP '(?<=\*\*Título:\*\* ).+' | \
        sort -u || echo ""
}

#-------------------------------------------------------------------------------
# Recopilar métricas de auditoría
#-------------------------------------------------------------------------------

collect_audit_metrics() {
    local audit_reports=$(find "${REPORTS_DIR}" -name "audit_report_*.md" -mtime -30 2>/dev/null | wc -l | tr -d ' ')
    local dda_reports=$(find "${REPORTS_DIR}" -name "dda_audit_report_*.md" -mtime -30 2>/dev/null | wc -l | tr -d ' ')
    local asrg_reports=$(find "${REPORTS_DIR}" -name "asrg_audit_report_*.md" -mtime -30 2>/dev/null | wc -l | tr -d ' ')

    echo "| Auditorías | CPAC: ${audit_reports} | DDA: ${dda_reports} | ASRG: ${asrg_reports} |"
}

#-------------------------------------------------------------------------------
# Recopilar estadísticas de tests
#-------------------------------------------------------------------------------

collect_test_stats() {
    local test_reports=$(find "${REPORTS_DIR}" -name "test_report_*.md" -mtime -30 2>/dev/null | wc -l | tr -d ' ')

    echo "| Tests | ${test_reports} ejecuciones registradas |"
}

#-------------------------------------------------------------------------------
# Generar changelog
#-------------------------------------------------------------------------------

generate_changelog() {
    local changelog_file="${PROJECT_ROOT}/CHANGELOG.md"
    local temp_file=$(mktemp)

    # Header
    cat > "${temp_file}" << EOF
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [${VERSION}] - ${TODAY//_/-}

### Added
$(collect_features | sed 's/^/- /' || echo "- Initial release")

### Fixed
$(collect_bugs | sed 's/^/- /' || echo "- No bugs fixed in this version")

### Changed
- Updated project documentation
$(collect_audit_metrics)
$(collect_test_stats)

### Audits
$(collect_audits | sed 's/^/- /' || echo "- No audits performed")

### Security
- No security changes

---

## Versiones Anteriores

$(if [ -f "${changelog_file}" ]; then
    echo "Ver historial completo en archivo anterior"
    head -50 "${changelog_file}"
fi)

---

*Generado automáticamente por FlutterCPAC - $(date +"%Y-%m-%d %H:%M:%S")*
EOF

    # Mover temp file a destino
    mv "${temp_file}" "${changelog_file}"

    print_success "CHANGELOG.md generado: ${changelog_file}"
}

#-------------------------------------------------------------------------------
# Generar summary para log
#-------------------------------------------------------------------------------

generate_summary() {
    print_header "Resumen de Cambios (últimos 30 días)"

    echo -e "${BLUE}Features:${NC}"
    collect_features | sed 's/^/  /' || echo "  Ninguna"

    echo -e "\n${RED}Bug Fixes:${NC}"
    collect_bugs | sed 's/^/  /' || echo "  Ninguno"

    echo -e "\n${YELLOW}Auditorías:${NC}"
    collect_audits | sed 's/^/  /' || echo "  Ninguna"

    echo -e "\n${GREEN}Tests:${NC}"
    collect_tests | sed 's/^/  /' || echo "  Ninguna"
}

#-------------------------------------------------------------------------------
# Main
#-------------------------------------------------------------------------------

main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║         FlutterCPAC - Changelog Generator v1.0.0            ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"

    # Verificar directorio de reportes
    if [ ! -d "${REPORTS_DIR}" ]; then
        print_warning "No se encontró directorio de reportes: ${REPORTS_DIR}"
        print_warning "Creando directorio..."
        mkdir -p "${REPORTS_DIR}"
    fi

    generate_summary
    generate_changelog

    echo -e "\n${GREEN}✓ Changelog generado exitosamente${NC}"
}

main "$@"
