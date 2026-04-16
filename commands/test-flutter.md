---
description: Ejecuta y documenta tests completos de un proyecto Flutter con resumen detallado
agent: *
---

Ejecuta un ciclo completo de testing para el proyecto Flutter actual, genera reportes detallados y registra los resultados.

### FASE 1: Preparación
1. **Lectura de SKILL (OBLIGATORIO):**
   - Evalúa `skills/flutter-cpac/SKILL.md` para entender la estructura de features
   - Identifica la estructura de tests existente en `test/` del proyecto

2. **Inventario de Tests:**
   - Escanea la carpeta `test/` para identificar todos los archivos de test
   - Clasifica por tipo:
     - **Unit Tests:** Tests de lógica pura (entities, repositories, use_cases)
     - **Bloc/Cubit Tests:** Tests de estado y transiciones
     - **Widget Tests:** Tests de componentes UI
     - **Integration Tests:** Tests de flujos completos
     - **Golden Tests:** Tests de regresión visual

### FASE 2: Ejecución de Tests
3. **Ejecutar Suite Completa:**
   ```
   flutter test --reporter expanded
   ```
   - Captura toda la salida stdout/stderr
   - Registra tiempo de ejecución total

4. **Ejecutar con Cobertura (si coverage disponible):**
   ```
   flutter test --coverage --reporter=html
   ```
   - Genera informe HTML en `coverage/`
   - Captura métricas de cobertura

5. **Ejecutar Unit Tests Separados:**
   ```
   flutter test test/unit/
   ```

6. **Ejecutar Widget Tests Separados:**
   ```
   flutter test test/widget/
   ```

7. **Ejecutar Bloc Tests Separados (si existen):**
   ```
   flutter test test/bloc/
   ```

8. **Ejecutar Golden Tests (si existen):**
   ```
   flutter test test/golden/
   ```

### FASE 3: Análisis de Resultados
9. **Parsear Resultados:**
   Por cada suite ejecutada, extraer:
   - Total de tests ejecutados
   - Tests pasados (passed)
   - Tests fallados (failed)
   - Tests ignorados/saltados (skipped)
   - Tiempo total de ejecución
   - Errores específicos de cada test fallido

10. **Capturar Evidencias:**
    - Si hay tests fallidos, capturar:
      - Nombre completo del test
      - Mensaje de error completo
      - Stack trace
      - Línea exacta del fallo
      - Captura de pantalla del fallo (si widget test)
    - Generar evidencia en `doc/reports/test_evidence_YYYY_MM_DD/`

### FASE 4: Generación de Reportes
11. **Generar TRES ficheros (OBLIGATORIO):**

    **Fichero 1 — Test Report Detallado:** `doc/reports/test_report_YYYY_MM_DD.md`
    - Usa el template `skills/flutter-cpac/templates/test_template.md`
    - Rellena con datos reales de la ejecución
    - Formato completo:
      ```
      # Flutter Test Report - YYYY-MM-DD

      ## Resumen de Ejecución
      - **Fecha:** YYYY-MM-DD
      - **Hora de inicio:** HH:mm:ss
      - **Hora de fin:** HH:mm:ss
      - **Duración total:** Xm Xs
      - **Resultado global:** ✅ ALL PASSED | ⚠️ PARTIAL | ❌ FAILED

      | Métrica | Unit | Widget | Bloc | Integration | **Total** |
      |---------|------|-------|------|-------------|-----------|
      | Ejecutados | X | X | X | X | **X** |
      | Pasados | X | X | X | X | **X** |
      | Fallidos | X | X | X | X | **X** |
      | Saltados | X | X | X | X | **X** |
      | Cobertura | X% | X% | X% | - | **X%** |

      ## Tests Fallidos (si existen)
      | # | Test | Tipo | Error | Línea |
      |---|------|------|-------|-------|
      | 1 | nombre_test | Unit | mensaje_error | archivo.dart:XX |

      ## Detalle de Suites

      ### Unit Tests
      - **Resultado:** ✅ Pasados / ❌ Fallidos
      - **Tiempo:** Xms
      - **Tests:** [lista]

      ### Widget Tests
      - **Resultado:** ✅ Pasados / ❌ Fallidos
      - **Tiempo:** Xms
      - **Tests:** [lista]

      ### Bloc Tests
      - **Resultado:** ✅ Pasados / ❌ Fallidos
      - **Tiempo:** Xms
      - **Tests:** [lista]

      ## Cobertura por Feature

      | Feature | Cobertura Líneas | Cobertura Funciones |
      |---------|------------------|---------------------|
      | feature_a | XX% | XX% |
      | feature_b | XX% | XX% |
      | **Media** | **XX%** | **XX%** |

      ## Evidencias
      - Carpeta: `doc/reports/test_evidence_YYYY_MM_DD/`
      - Ver: `test_evidence_YYYY_MM_DD.md`

      ## Recomendaciones
      - [ ] Prioridad 1: Arreglar tests fallidos
      - [ ] Prioridad 2: Aumentar cobertura en...
      - [ ] Prioridad 3: Añadir golden tests para...

      ## Próximos Pasos
      - Ejecutar tests después de cada feature
      - Mantener cobertura > 80%
      - Revisar tests obsoletos
      ```

    **Fichero 2 — Evidencias:** `doc/reports/test_evidence_YYYY_MM_DD.md`
    - Documenta cada test fallido con evidencia completa:
      ```
      # Test Evidence - YYYY-MM-DD

      ## Tests Fallidos

      ### Test #1: [nombre_completo]
      - **Tipo:** Unit | Widget | Bloc
      - **Archivo:** `test/.../nombre_test.dart`
      - **Línea:** XX
      - **Fecha/Hora:** YYYY-MM-DD HH:mm:ss

      **Error:**
      ```
      [stack trace completo]
      ```

      **Screenshot (si aplica):**
      ![screenshot](test_evidence_YYYY_MM_DD/screenshot_01.png)

      **Diagnóstico:**
      [分析 del error]

      ---

      ### Test #2: [nombre_completo]
      ...

      ## Resumen de Errores
      - **Total errores:** X
      - **Errores de aserción:** X
      - **Errores de timeout:** X
      - **Errores de sintaxis:** X
      - **Errores de dependencias:** X

      ## Plan de Acción
      | Error | Prioridad | Asignado | Estado |
      |-------|-----------|----------|--------|
      | ... | Alta | - | Pending |
      ```

    **Fichero 3 — Log de Sesión:** `doc/reports/log_report_YYYY_MM_DD.md`
    - Usa el template `skills/flutter-cpac/templates/log_template.md`
    - Añade entrada tipo **TEST**:
      ```
      **Acción:** TEST

      **Título:** Testing Suite - YYYY-MM-DD

      **Descripción:** Ejecución completa de tests unitarios, widget y bloc

      **Resultados:**
      - Ejecutados: X
      - Pasados: X
      - Fallidos: X
      - Cobertura: X%

      **Test Report:** doc/reports/test_report_YYYY_MM_DD.md
      **Evidencias:** doc/reports/test_evidence_YYYY_MM_DD.md
      ```

### FASE 5: Resumen y Recomendaciones
12. **Mostrar Resumen en Chat:**
    ```
    ╔══════════════════════════════════════════════════════════════╗
    ║              TEST REPORT SUMMARY - YYYY-MM-DD                ║
    ╠══════════════════════════════════════════════════════════════╣
    ║  Tests: X executed | X passed | X failed | X skipped        ║
    ║  Coverage: XX% lines | XX% functions                        ║
    ║  Duration: Xm Xs                                            ║
    ╠══════════════════════════════════════════════════════════════╣
    ║  Status: ✅ ALL PASSED | ⚠️ NEEDS ATTENTION | ❌ FAILED    ║
    ╚══════════════════════════════════════════════════════════════╝
    ```

13. **Recomendaciones Prioritarias:**
    - Si hay tests fallidos → Prioridad ALTA
    - Si cobertura < 70% → Prioridad MEDIA
    - Si hay tests obsoletos → Prioridad BAJA

14. **PREGUNTA al programador:**
    - Si hay tests fallidos: ¿Desea que un agente diagnostique y arregle los tests?
    - Si cobertura baja: ¿Desea que se añadan más tests unitarios?
    - Si no hay tests: ¿Desea que se cree una suite inicial de tests?
