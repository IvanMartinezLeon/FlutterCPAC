---
description: Refactoriza automáticamente deuda técnica de un proyecto Flutter
agent: *
---

Ejecuta refactorización masiva de deuda técnica siguiendo las reglas CPAC.

### FASE 1: Análisis de Deuda
1. **Ejecutar flutter analyze:**
   ```
   flutter analyze 2>&1 | tee doc/reports/refactor_audit_YYYY_MM_DD.txt
   ```

2. **Categorizar issues:**
   - 🔴 **Críticos:** Errores de compilación
   - 🟡 **Warnings:** Código smell
   - 🟢 **Info:** Sugerencias

3. **Detectar patrones de deuda técnica:**
   ```
   # Hardcoded spacing
   grep -rn "EdgeInsets.all([0-9]" lib/ --include="*.dart"

   # Hardcoded colors
   grep -rn "Color(0xFF" lib/ --include="*.dart"

   # Hardcoded durations
   grep -rn "Duration(milliseconds:" lib/ --include="*.dart"

   # Non-const constructors
   grep -rn "EdgeInsets\|BorderRadius\|BoxShadow" lib/ --include="*.dart" | grep -v "const"

   # setState fuera de widgets
   grep -rn "setState" lib/features --include="*.dart" | grep -v "presentation"

   # Dynamic types
   grep -rn "dynamic" lib/ --include="*.dart"
   ```

### FASE 2: Auto-Fix Automático
4. **Aplicar fixes seguros:**
   ```
   dart fix --apply
   ```

5. **Formatear código:**
   ```
   dart format .
   ```

6. **Verificar analyze post-fix:**
   ```
   flutter analyze
   ```

### FASE 3: Refactorización Manual
7. **Refactorización de Spacing:**

   | Antes | Después |
   |-------|---------|
   | `EdgeInsets.all(12)` | `EdgeInsets.all(AppSpacing.md)` |
   | `SizedBox(height: 20)` | `SizedBox(height: AppSpacing.lg)` |
   | `Padding(padding: EdgeInsets.all(8))` | `Padding(padding: EdgeInsets.all(AppSpacing.sm))` |

8. **Refactorización de Colores:**
   ```
   // ANTES
   Color(0xFF2196F3)

   // DESPUÉS
   Theme.of(context).colorScheme.primary
   // o
   AppColors.primary
   ```

9. **Refactorización de Durations:**
   ```
   // ANTES
   Duration(milliseconds: 300)

   // DESPUÉS
   AppMotion.medium
   // o
   Duration(milliseconds: AppMotionDurations.medium)
   ```

10. **Añadir const:**
    ```dart
    // ANTES
    Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
    )

    // DESPUÉS
    const Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(AppRadius.md),
      ),
    )
    ```

11. **Refactorización de Strings:**
    ```dart
    // ANTES
    Text('Hello World')

    // DESPUÉS
    Text(context.l10n.helloWorld)
    ```

### FASE 4: Refactorización Estructural
12. **Extraer widgets repetidos:**
    - Identificar widgets usados ≥3 veces
    - Crear componente compartido
    - Actualizar usages

13. **Migrar setState a Cubit:**
    ```dart
    // ANTES (StatefulWidget con setState)
    class _CounterWidgetState extends State<_CounterWidget> {
      int _count = 0;

      void _increment() => setState(() => _count++);
    }

    // DESPUÉS (Cubit)
    class CounterCubit extends Cubit<int> {
      CounterCubit() : super(0);
      void increment() => emit(state + 1);
    }
    ```

14. **Consolidar repositories duplicados:**
    - Buscar lógica repetida en features
    - Mover a `core/` si es compartido

### FASE 5: Verificación
15. **Ejecutar analyze:**
    ```
    flutter analyze
    ```

16. **Ejecutar tests:**
    ```
    ./scripts/run_tests.sh
    ```

17. **Verificar cobertura:**
    ```
    flutter test --coverage
    ```

### FASE 6: Documentación
18. **Generar Refactor Report:** `doc/reports/refactor_report_YYYY_MM_DD.md`
    ```
    # Refactor Report - YYYY-MM-DD

    ## Resumen
    - **Archivos modificados:** X
    - **Líneas cambiadas:** X
    - **Issues resueltos:** X
    - **Tests passing:** X/X

    ## Categorías de Refactor

    ### Spacing Hardcoded → Tokens
    | Archivo | Antes | Después |
    |---------|-------|---------|
    | ... | ... | ... |

    ### Colores Hardcoded → Theme
    | Archivo | Antes | Después |
    |---------|-------|---------|
    | ... | ... | ... |

    ### Durations Hardcoded → AppMotion
    | Archivo | Antes | Después |
    |---------|-------|---------|
    | ... | ... | ... |

    ### Widgets Extraídos
    | Widget | Ubicación | Usages |
    |--------|-----------|--------|
    | AppButton | shared/widgets/ | 12 |

    ### StatefulWidget → Cubit
    | Antes | Después |
    |-------|---------|
    | _CounterState | CounterCubit |

    ## Issues Pendientes

    | # | Issue | Prioridad | Estado |
    |---|-------|-----------|--------|
    | 1 | ... | Alta | Pending |

    ## Recomendaciones

    - [ ] Revisar widgets extraídos
    - [ ] Verificar breakpoints responsive
    - [ ] Actualizar documentación de features
    ```

### FASE 7: Commit
19. **Crear commit atómico:**
    ```
    git add -p
    git commit -m "refactor: resolve technical debt - spacing, colors, durations

    - Replace hardcoded spacing with AppSpacing tokens
    - Migrate hardcoded colors to Theme
    - Extract X shared widgets
    - Migrate X StatefulWidget to Cubit

    BREAKING CHANGE: N/A
    Refs: doc/reports/refactor_report_YYYY_MM_DD.md"
    ```

### Checklist de Refactor

- [ ] flutter analyze: 0 errores
- [ ] Tests passing
- [ ] Cobertura mantenida ≥ 70%
- [ ] No hardcoded spacing
- [ ] No hardcoded colors
- [ ] No hardcoded durations
- [ ] Constructores const donde sea posible
- [ ] Refactor Report generado
- [ ] Commit creado
- [ ] Log actualizado
