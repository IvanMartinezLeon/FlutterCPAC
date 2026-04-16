---
description: Migra proyecto Flutter a nuevas versiones de Flutter/Dart/paquetes
agent: *
---

Ejecuta migración completa de un proyecto Flutter a nuevas versiones, manteniendo la arquitectura CPAC.

### FASE 1: Análisis Pre-Migración
1. **Inventario de Versiones Actuales:**
   ```
   flutter --version
   dart --version
   cat pubspec.lock | grep -A2 "packages:"
   ```

2. **Analizar pubspec.yaml:**
   - Identificar versiones de paquetes
   - Detectar paquetes deprecated
   - Verificar compatibilidad con target de Flutter

3. **Backup del proyecto:**
   ```
   git tag pre-migration-YYYYMMDD
   ```

### FASE 2: Migración de Flutter/Dart
4. **Migrar Flutter SDK:**
   ```
   flutter upgrade
   flutter doctor
   ```

5. **Migrar Dart:**
   - Revisar `dart-lang/sdk` changelog
   - Actualizar constraints en pubspec.yaml si necesario

6. **Migrar paquetes a null-safety:**
   ```
   dart pub upgrade --null-safety
   ```
   - Si hay errores, usar `dart migrate`

### FASE 3: Migración de Paquetes
7. **Actualizar pubspec.yaml:**
   ```
   dart pub outdated
   ```
   - Identificar actualizaciones necesarias
   - Priorizar: major → minor → patch

8. **Migrar paquetes específicos:**

   | Paquete | Guía de migración |
   |---------|-------------------|
   | `flutter_bloc` | Revisar breaking changes en Bloc/Cubit |
   | `get_it` | Ver cambios en RegisterType |
   | `dio` | Revisar breaking changes en interceptores |
   | `freezed` | Actualizar a latest + regenerate |
   | `go_router` | Ver cambios en ShellRoute |

9. **Regenerar código:**
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```

### FASE 4: Corrección de Breaking Changes
10. **Ejecutar flutter analyze:**
    ```
    flutter analyze 2>&1 | tee doc/reports/migration_errors_YYYY_MM_DD.txt
    ```

11. **Categorizar errores:**
    - ❌ **Breaking Changes:** Requieren refactorización manual
    - ⚠️ **Deprecations:** Reemplazar con nueva API
    - ✅ **Automáticos:** `dart fix --apply`

12. **Aplicar fixes automáticos:**
    ```
    dart fix --apply
    flutter analyze
    ```

13. **Corrección manual de breaking changes:**
    - Documentar cada cambio en `doc/reports/migration_report_YYYY_MM_DD.md`

### FASE 5: Testing Post-Migración
14. **Ejecutar tests:**
    ```
    ./scripts/run_tests.sh
    ```

15. **Verificar cobertura:**
    - Comparar con pre-migración
    - Asegurar ≥ 70%

16. **Build de verificación:**
    ```
    flutter build apk --debug
    flutter build ios --simulator --no-codesign
    ```

### FASE 6: Documentación
17. **Generar Migration Report:** `doc/reports/migration_report_YYYY_MM_DD.md`
    ```
    # Migration Report - YYYY-MM-DD

    ## Resumen
    - **De:** Flutter X.X → X.X | Dart X.X → X.X
    - **Duración:** X horas
    - **Breaking Changes:** X
    - **Tests passing:** X/X

    ## Paquetes Actualizados

    | Paquete | Antes | Después | Breaking Changes |
    |---------|-------|---------|------------------|
    | flutter_bloc | X.X | X.X | Sí/No |
    | ... | ... | ... | ... |

    ## Breaking Changes Resueltos

    ### 1. [Nombre]
    - **Descripción:** ...
    - **Solución:** ...

    ## Issues Pendientes

    | # | Issue | Prioridad | Estado |
    |---|-------|-----------|--------|
    | 1 | ... | Alta | Pending |

    ## Recomendaciones

    - [ ] Probar en dispositivo real
    - [ ] Revisar logs de production
    - [ ] Monitorizar crashes post-deploy
    ```

18. **Actualizar SPEC.md si hay cambios de arquitectura:**
    - Documentar cambios en estructura
    - Actualizar dependencias

### FASE 7: Log de Sesión
19. **Crear log_report_YYYY_MM_DD.md:**
    ```
    **Acción:** MIGRATION

    **Título:** Migración Flutter/Dart - YYYY-MM-DD

    **Descripción:** Migración de Flutter X.X → X.X con X paquetes actualizados

    **Resultados:**
    - Breaking changes: X
    - Tests passing: X/X
    - Issues pendientes: X

    **Migration Report:** doc/reports/migration_report_YYYY_MM_DD.md
    ```

### Checklist de Migración

- [ ] Flutter SDK actualizado
- [ ] Dart actualizado
- [ ] Todos los paquetes en latest compatible
- [ ] Null-safety verificado
- [ ] Código regenerado (build_runner)
- [ ] 0 errores en `flutter analyze`
- [ ] Tests passing
- [ ] Build exitoso (iOS + Android)
- [ ] Migration Report generado
- [ ] Log actualizado
