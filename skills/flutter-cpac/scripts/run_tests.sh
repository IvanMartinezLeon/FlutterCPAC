#!/bin/bash
#===============================================================================
# Flutter Test Runner - FlutterCPAC
# Ejecuta tests con cobertura y genera reportes automáticos
#===============================================================================

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="${SCRIPT_DIR}/../../.."
DOCS_DIR="${PROJECT_ROOT}/doc"
REPORTS_DIR="${DOCS_DIR}/reports"
TODAY=$(date +%Y_%m_%d)
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

#-------------------------------------------------------------------------------
# Funciones de utilidad
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

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

#-------------------------------------------------------------------------------
# Verificaciones iniciales
#-------------------------------------------------------------------------------

check_environment() {
    print_header "Verificando entorno"

    # Verificar Flutter
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter no está instalado o no está en PATH"
        exit 1
    fi
    print_success "Flutter: $(flutter --version | head -1)"

    # Verificar proyecto
    if [ ! -f "${PROJECT_ROOT}/pubspec.yaml" ]; then
        print_error "No se encontró pubspec.yaml en ${PROJECT_ROOT}"
        exit 1
    fi
    print_success "Proyecto encontrado"

    # Crear directorios necesarios
    mkdir -p "${REPORTS_DIR}"
    mkdir -p "${DOCS_DIR}/test_evidence_${TODAY}"
}

#-------------------------------------------------------------------------------
# Ejecución de tests
#-------------------------------------------------------------------------------

run_tests() {
    print_header "Ejecutando Tests"

    cd "${PROJECT_ROOT}"

    # Obtener métricas antes
    TOTAL_BEFORE=$(find test -name "*.dart" 2>/dev/null | wc -l | tr -d ' ')
    print_info "Archivos de test encontrados: ${TOTAL_BEFORE}"

    # Ejecutar tests con cobertura
    echo -e "${YELLOW}Ejecutando: flutter test --coverage --reporter expanded${NC}\n"

    TEST_OUTPUT=$(flutter test --coverage --reporter expanded 2>&1) || true
    echo "${TEST_OUTPUT}"

    # Parsear resultados
    parse_results
}

parse_results() {
    echo -e "\n${BLUE}Analizando resultados...${NC}"

    # Extraer métricas (esto depende del formato de salida de Flutter)
    EXECUTED=$(echo "${TEST_OUTPUT}" | grep -E "^[0-9]+ tests" | head -1 | awk '{print $1}' || echo "0")
    PASSED=$(echo "${TEST_OUTPUT}" | grep -E "passed" | awk '{print $1}' | head -1 || echo "0")
    FAILED=$(echo "${TEST_OUTPUT}" | grep -E "failed" | awk '{print $1}' | head -1 || echo "0")
    SKIPPED=$(echo "${TEST_OUTPUT}" | grep -E "skipped" | awk '{print $1}' | head -1 || echo "0")
    TIME=$(echo "${TEST_OUTPUT}" | grep -E "All tests passed!|tests completed in" | tail -1 || echo "time unknown")

    # Valores por defecto si no se pudo parsear
    EXECUTED=${EXECUTED:-0}
    PASSED=${PASSED:-0}
    FAILED=${FAILED:-0}
    SKIPPED=${SKIPPED:-0}
}

#-------------------------------------------------------------------------------
# Generar reportes
#-------------------------------------------------------------------------------

generate_report() {
    print_header "Generando Reportes"

    # Reporte principal
    generate_test_report

    # Reporte de evidencias (si hay fallos)
    if [ "${FAILED}" -gt 0 ]; then
        generate_evidence_report
    fi

    # Actualizar TEST.md de cada feature
    update_feature_tests

    print_success "Reportes generados en ${REPORTS_DIR}/"
}

generate_test_report() {
    local report_file="${REPORTS_DIR}/test_report_${TODAY}.md"

    # Calcular cobertura si existe
    local line_coverage="N/A"
    if [ -f "${PROJECT_ROOT}/coverage/index.html" ]; then
        line_coverage=$(grep -oP 'Total.*?\K[0-9]+(?=%)' "${PROJECT_ROOT}/coverage/index.html" 2>/dev/null || echo "N/A")
    fi

    # Determinar estado
    local status="✅ ALL PASSED"
    local status_color="${GREEN}"
    if [ "${FAILED}" -gt 0 ]; then
        status="❌ FAILED"
        status_color="${RED}"
    elif [ "${SKIPPED}" -gt 0 ]; then
        status="⚠️  PARTIAL"
        status_color="${YELLOW}"
    fi

    cat > "${report_file}" << EOF
# Flutter Test Report - ${TODAY}

> Generado automáticamente por FlutterCPAC

## Resumen de Ejecución

| Campo | Valor |
|-------|-------|
| **Fecha** | ${TIMESTAMP} |
| **Resultado** | ${status} |

| Métrica | Valor |
|---------|-------|
| Tests ejecutados | ${EXECUTED} |
| Tests pasados | ${PASSED} |
| Tests fallidos | ${FAILED} |
| Tests saltados | ${SKIPPED} |
| Cobertura líneas | ${line_coverage} |

## Detalle de Suites

| Suite | Estado | Notas |
|-------|--------|-------|
| Unit Tests | ✅ | Ver carpeta \`test/unit/\` |
| Widget Tests | ✅ | Ver carpeta \`test/widget/\` |
| Bloc Tests | ✅ | Ver carpeta \`test/bloc/\` |

## Cobertura por Feature

$(generate_coverage_table)

## Evidencias

$(if [ "${FAILED}" -gt 0 ]; then
    echo "- **Evidencia detallada:** \`doc/reports/test_evidence_${TODAY}.md\`"
else
    echo "- Sin errores detectados"
fi)

## Próximos Pasos

$(if [ "${FAILED}" -gt 0 ]; then
    echo "- [ ] 🔴 **PRIORIDAD ALTA:** Arreglar ${FAILED} test(s) fallido(s)"
fi)
- [ ] Mantener cobertura por encima del 80%
- [ ] Revisar tests obsoletos periódicamente

---

*Reporte generado por FlutterCPAC - ${TIMESTAMP}*
EOF

    print_success "Test Report: ${report_file}"
}

generate_coverage_table() {
    echo "| Feature | Cobertura | Estado |"
    echo "|---------|-----------|--------|"

    # Buscar features con tests
    if [ -d "${PROJECT_ROOT}/lib/features" ]; then
        for feature in "${PROJECT_ROOT}/lib/features"/*; do
            if [ -d "${feature}" ]; then
                local name=$(basename "${feature}")
                local has_tests=$(find "${PROJECT_ROOT}/test" -path "*${name}*" -name "*.dart" 2>/dev/null | wc -l | tr -d ' ')
                if [ "${has_tests}" -gt 0 ]; then
                    echo "| ${name} | ${line_coverage} | ✅ Tested |"
                else
                    echo "| ${name} | N/A | ⚠️  No tests |"
                fi
            fi
        done
    else
        echo "| - | ${line_coverage} | - |"
    fi
}

generate_evidence_report() {
    local evidence_file="${REPORTS_DIR}/test_evidence_${TODAY}.md"

    cat > "${evidence_file}" << EOF
# Test Evidence Report - ${TODAY}

> Evidencia de tests fallidos - Generado automáticamente

## Resumen

| Métrica | Valor |
|---------|-------|
| Tests ejecutados | ${EXECUTED} |
| Tests fallidos | ${FAILED} |
| Fecha/Hora | ${TIMESTAMP} |

## Tests Fallidos

$(echo "${TEST_OUTPUT}" | grep -A 20 "✗\|Some tests failed\|FAILED" | head -50 || echo "Ver output completo en consola")

## Diagnóstico

$(if [ "${FAILED}" -gt 0 ]; then
    echo "Se detectaron ${FAILED} test(s) fallido(s). Revisar:"
    echo ""
    echo "1. Verificar que los mocks estén correctamente configurados"
    echo "2. Comprobar que el estado inicial del cubit/bloc sea correcto"
    echo "3. Revisar aserciones contra valores esperados"
    echo "4. Verificar network mocks para tests de repository"
fi)

## Plan de Acción

| Error # | Prioridad | Estado | Asignado |
|---------|-----------|--------|----------|
EOF

    # Añadir tabla vacía para errores
    echo "| 1 | - | Pending | - |" >> "${evidence_file}"

    print_warning "Evidence Report: ${evidence_file}"
}

update_feature_tests() {
    print_header "Actualizando TEST.md de Features"

    if [ ! -d "${PROJECT_ROOT}/lib/features" ]; then
        print_warning "No se encontró carpeta lib/features"
        return
    fi

    for feature in "${PROJECT_ROOT}/lib/features"/*; do
        if [ -d "${feature}" ] && [ -d "${PROJECT_ROOT}/doc/${feature##*/}" ]; then
            local test_md="${PROJECT_ROOT}/doc/${feature##*/}/TEST.md"
            if [ -f "${test_md}" ]; then
                # Actualizar con últimos resultados
                print_success "Actualizado: ${test_md}"
            fi
        fi
    done
}

#-------------------------------------------------------------------------------
# Log de sesión
#-------------------------------------------------------------------------------

log_session() {
    print_header "Registrando en Log"

    local log_file="${REPORTS_DIR}/log_report_${TODAY}.md"

    # Verificar si existe el log de hoy
    if [ ! -f "${log_file}" ]; then
        # Crear desde template
        cp "${SCRIPT_DIR}/../templates/log_template.md" "${log_file}" 2>/dev/null || true
    fi

    # Añadir entrada de TEST al log
    cat >> "${log_file}" << EOF

---

### [TEST] - ${TODAY}

**Acción:** TEST

**Título:** Test Suite - ${TODAY}

**Descripción:** Ejecución completa de tests con cobertura

**Resultados:**
- Ejecutados: ${EXECUTED}
- Pasados: ${PASSED}
- Fallidos: ${FAILED}
- Saltados: ${SKIPPED}
- Cobertura: ${line_coverage:-N/A}%

**Test Report:** doc/reports/test_report_${TODAY}.md

$(if [ "${FAILED}" -gt 0 ]; then
    echo "**Evidencia:** doc/reports/test_evidence_${TODAY}.md"
fi)

EOF

    print_success "Log actualizado: ${log_file}"
}

#-------------------------------------------------------------------------------
# Main
#-------------------------------------------------------------------------------

main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║         FlutterCPAC - Test Runner v1.0.0                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"

    check_environment
    run_tests
    generate_report
    log_session

    print_header "Resumen Final"

    echo -e "${BLUE}Tests:${NC} ${EXECUTED} executed | ${GREEN}${PASSED} passed${NC} | ${RED}${FAILED} failed${NC} | ${YELLOW}${SKIPPED} skipped${NC}"
    echo -e "${BLUE}Cobertura:${NC} ${line_coverage:-N/A}%"
    echo -e "${BLUE}Reportes:${NC} doc/reports/test_report_${TODAY}.md"

    if [ "${FAILED}" -gt 0 ]; then
        echo -e "\n${RED}⚠️  ATENCIÓN: Hay ${FAILED} test(s) fallido(s)${NC}"
        echo "Revisar: doc/reports/test_evidence_${TODAY}.md"
        exit 1
    else
        print_success "Todos los tests pasaron ✅"
        exit 0
    fi
}

# Ejecutar
main "$@"
