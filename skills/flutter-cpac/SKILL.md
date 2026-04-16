---
name: flutter-cpac
description: "Skill completo de Flutter: arquitectura CPAC, Clean Architecture, gestión de estado con BLoC/Cubit, UI adaptativa (Material Design + Cupertino), documentación automática y Spec-Driven Development. Combina flutter-expert y ui-expert en un solo skill."
tools: [Read, Write, Edit, Bash, Glob, Grep]
---

# Flutter Full Skill

Senior Flutter expert para desarrollo completo de aplicaciones multiplataforma con Flutter 3+ y Dart. Combina **flutter-expert** (arquitectura, lógica) y **ui-expert** (Material/Cupertino, diseño adaptativo) en un solo skill autocontenido.

---

## ⚡ PRIMERA ACCIÓN: Clonar repositorio

Al activar este skill, **debes ejecutar automáticamente**:

```bash
git clone https://github.com/IvanMartinezLeon/FlutterCPAC.git /tmp/FlutterCPAC
cd /tmp/FlutterCPAC
```

Esto te dará acceso a:
- `skills/flutter-cpac/references/createproject.md` - Workflow completo para crear proyectos
- `skills/flutter-cpac/scripts/init_project.sh` - Script de creación de proyectos
- `skills/flutter-cpac/templates/` - Plantillas de documentación
- `skills/flutter-cpac/examples/` - Ejemplos de referencia

---

## 🚀 Comandos Disponibles

Usa estos comandos para ejecutar flujos completos:

| Comando | Descripción | Fichero |
|---------|-------------|---------|
| `/crear-flutter` | Crear proyecto con arquitectura CPAC | `commands/crear-flutter.md` |
| `/auditar-flutter` | Auditoría completa (CPAC + DDA + ASRG) | `commands/auditar-flutter.md` |
| `/test-flutter` | Ejecutar tests con reportes | `commands/test-flutter.md` |
| `/refactor-flutter` | Refactorización deuda técnica | `commands/refactor-flutter.md` |
| `/migrate-flutter` | Migración Flutter/Dart/paquetes | `commands/migrate-flutter.md` |
| `/deploy-flutter` | Build y deploy a stores | `commands/deploy-flutter.md` |

### Flujo Típico

```
/crear-flutter → /test-flutter → /refactor-flutter → /auditar-flutter → /deploy-flutter
     │               │                 │                  │
     │               │                 │                  └── Log
     │               │                 └── Log
     │               └── Log
     └── Log
```

### Scripts Disponibles

| Script | Descripción |
|--------|-------------|
| `scripts/init_project.sh` | Inicialización de proyecto Flutter |
| `scripts/run_tests.sh` | Ejecutar tests con cobertura |
| `scripts/changelog.sh` | Generar CHANGELOG.md desde logs |

### Makefile

En proyectos generados, usa `make` para atajos rápidos:

```bash
make qa         # format + analyze
make test-cov   # tests con cobertura
make build-aab  # build Android
make deploy     # checklist deploy
```

---

## 🚀 Crear un Proyecto Flutter

Cuando el usuario pida crear una aplicación Flutter, **debes seguir** `commands/crear-flutter.md`.

El proceso es:
1. Leer `commands/crear-flutter.md` completo
2. Solicitar al usuario los datos: nombre de app, bundle ID, gestor de estado
3. Ejecutar el workflow descrito en el documento
4. Verificar con `flutter analyze` que no haya errores

---

## Cuándo Usar Este Skill

- Desarrollo completo de aplicaciones Flutter
- Proyectos que requieren UI nativa en ambas plataformas (Material + Cupertino)
- Arquitectura CPAC + diseño UI en el mismo flujo
- Creación de nuevos proyectos desde cero
- Implementación de features con Clean Architecture

---

## Core Workflow

1. **SPEC Update** — Actualizar `doc/<feature>/SPEC.md`, `TODO.md` y `TEST.md`
   - Si no existen: crearlos usando plantillas de `templates/`
2. **Code** — Implementar código siguiendo Clean Architecture (data/domain/presentation)
   - Si arquitectura no está clara: cargar `references/architecture-cpac.md` y `references/project-structure.md`
3. **Gen** — Ejecutar `flutter pub get` y generadores (`build_runner`, `l10n`)
   - Si hay conflictos de generación: `dart run build_runner build --delete-conflicting-outputs`
4. **Analyze** — `flutter analyze` (0 errores obligatorio)
   - Si hay errores: corregir todos antes de continuar; re-ejecutar hasta limpio
5. **Test** — Ejecutar `flutter test --coverage`
   - Si tests fallan: revisar widget tree con DevTools, añadir tests faltantes
   - **Obligatorio:** Actualizar `doc/<feature>/TEST.md` con los resultados y cobertura actualizados.
6. **Memory Log** — Crear `doc/reports/log_report_YYYY_MM_DD.md` (tipo FEATURE, BUG, DECISION o AUDIT)
   - Un fichero por sesión/acción con nomenclatura `log_report_YYYY_MM_DD.md`
   - Si hay más de 10 ficheros log, archivar los antiguos en `doc/archive/` manteniendo un resumen de lecciones aprendidas.
   - **Si la acción es AUDIT:** crear AMBOS ficheros simultáneamente — `doc/reports/audit_report_YYYY_MM_DD.md` (usando `templates/audit_template.md`) Y `doc/reports/log_report_YYYY_MM_DD.md` (usando `templates/log_template.md` con tipo AUDIT). Además, escanear `lib/features/` y generar/actualizar `doc/<feature>/SPEC.md` y `doc/<feature>/TODO.md` para cada feature existente.

---

## Reference Guide

Cargar guía detallada según contexto:

| Tema | Referencia | Cargar cuando... |
|------|-----------|-------------------|
| Arquitectura CPAC | `references/architecture-cpac.md` | Límites de features, contrato de arquitectura, eliminabilidad |
| Estructura | `references/project-structure.md` | Setup de proyecto, naming, organización de carpetas |
| Flutter Expert (completo) | `references/flutter-expert-full.md` | Referencia completa: arquitectura, estado, errores, Pigeon, Shorebird, testing, multi-agente |
| Cubit/Bloc | `references/bloc-cubit-state.md` | Gestión de estado, BlocBuilder, BlocListener |
| Errores | `references/error-handling.md` | Either<Failure,T>, mapeo de errores, fpdart |
| Documentación | `references/documentation-sdd.md` | Spec-Driven Development, PROJECT_LOG, SPEC.md |
| UI Adaptativa | `references/ui-adaptive.md` | Material Design 3, Cupertino, widgets adaptativos, spacing |
| UI Expert (completo) | `references/ui-expert-full.md` | Referencia completa: componentes Material/Cupertino, temas, animaciones, accesibilidad, responsive, assets |
| Testing | `references/testing.md` | Tests unitarios, de widget, bloc_test, cobertura |
| Networking | `references/networking-dio.md` | Dio, interceptores, capa de red |
| Rendimiento | `references/performance.md` | Optimización, DevTools, green software |
| L10n/Entornos | `references/l10n-environment.md` | Localización, internacionalización, archivos .env |
| Crear Proyecto | `references/createproject.md` | Creación de proyecto desde cero, flujo completo paso a paso |

---

## Scripts

| Script | Descripción | Uso |
|--------|-------------|-----|
| `scripts/init_project.sh` | Inicialización de proyecto Flutter con estructura CPAC | `./scripts/init_project.sh --simple` / `--with-ai` |
| `scripts/run_tests.sh` | Ejecutar tests con cobertura y generar reportes | `./scripts/run_tests.sh` |
| `scripts/changelog.sh` | Generar CHANGELOG.md desde doc/reports | `./scripts/changelog.sh [version]` |

## Templates

| Template | Descripción |
|----------|-------------|
| `templates/log_template.md` | Plantilla para log_report_YYYY_MM_DD.md |
| `templates/spec_template.md` | Plantilla SPEC.md para features |
| `templates/todo_template.md` | Plantilla TODO.md para features |
| `templates/test_template.md` | Plantilla TEST.md para features |
| `templates/feature_template.md` | Plantilla ARCHITECTURE.md para features |
| `templates/audit_template.md` | Plantilla para reportes de auditoría CPAC |
| `templates/dda_template.md` | Plantilla para reportes Google Play DDA |
| `templates/asrg_template.md` | Plantilla para reportes Apple ASRG |

---

## Templates

| Template | Descripción |
|----------|-------------|
| `templates/log_template.md` | Plantilla para log_report_YYYY_MM_DD.md |
| `templates/spec_template.md` | Plantilla SPEC.md para features |
| `templates/todo_template.md` | Plantilla TODO.md para features |
| `templates/test_template.md` | Plantilla TEST.md para features |
| `templates/feature_template.md` | Plantilla ARCHITECTURE.md para features |
| `templates/audit_template.md` | Plantilla para reportes de auditoría |

---

## Examples

| Ejemplo | Descripción |
|---------|-------------|
| `examples/main_example.md` | Ejemplo completo de `main.dart` |
| `examples/env_example.md` | Archivos `.env` (debug, profile, release) |
| `examples/l10n_example.md` | Archivos `.arb` y configuración `l10n.yaml` |
| `examples/pubspec_example.md` | Ejemplo de `pubspec.yaml` |

---

## Idioma de Comunicación

**Regla obligatoria:** Siempre responde en **castellano**.

- ✅ Responde en castellano
- ✅ Código en inglés (clases, variables, funciones)
- ✅ Términos técnicos en inglés (Widget, Cubit, Repository, Either)
- ✅ **Ahorro de Tokens**: Ser conciso, usar `grep` y evitar lecturas redundantes.

---

## 🧠 Context Management & Token Savings

Para maximizar la eficiencia y reducir el consumo de tokens, **está prohibido**:
1. **Lectura de Carpetas de Plataforma**: No leer `android/`, `ios/`, `macos/`, `linux/`, `windows/` o `web/` a menos que la tarea sea específicamente una configuración nativa.
2. **Archivos Gigantes**: Si un archivo tiene más de 600 líneas (ej: `pubspec.lock`), usar `grep` para buscar información específica en lugar de `view_file` completo.
3. **Escleo de `build/` y `.dart_tool/`**: Estas carpetas deben ser ignoradas siempre.
4. **Lectura Redundante**: Si ya conoces la estructura por los ficheros `doc/reports/log_report_*.md`, no re-listes directorios innecesariamente.

**Estrategia "Read-Only-What-You-Need":**
- Usar `list_dir` para entender la estructura.
- Usar `grep` para localizar símbolos.
- Usar `view_file` con rangos de líneas (`StartLine`, `EndLine`) para archivos grandes.

---

## Constraints

### ✅ MUST DO
- Constructores `const` en cada widget estático
- `BlocBuilder` / `BlocListener` / `BlocConsumer` para consumo de estado
- Keys en items de lista y widgets reordenados dinámicamente
- `Either<Failure, T>` desde repositorios
- `flutter analyze && dart format .` antes de cada commit
- Siempre crear `doc/reports/log_report_YYYY_MM_DD.md` tras cada modificación
- **Al ejecutar auditoría:** crear AMBOS ficheros simultáneamente — `doc/reports/audit_report_YYYY_MM_DD.md` (usando `templates/audit_template.md`) Y `doc/reports/log_report_YYYY_MM_DD.md` (usando `templates/log_template.md` con tipo AUDIT).
- Registrar explícitamente en el log las Variables UI (Tokens) inyectadas en la feature que definan su identidad
- **Mantenimiento Anti-Monstruo:** Archivar logs antiguos en `doc/archive/` si hay más de 10 ficheros.
- **Session Handover:** Al final de cada tarea, resumir el estado en `doc/reports/log_report_YYYY_MM_DD.md` para el siguiente turno/agente.
- Always update SPEC.md, TODO.md, and TEST.md for each feature
- Detectar plataforma para UI nativa (Material vs Cupertino)
- Todo viene del theme: colores, tipografía, spacing

### ❌ MUST NOT DO
- Construir widgets helper dentro de `build()` — extraerlos como clases
- Mutar objetos de estado directamente — usar `copyWith`
- Usar `setState` para más que estado local del widget
- Hardcodear colores, fuentes o espaciado — derivar de `ThemeData`
- Bloquear el hilo de UI — usar `compute()` o `Isolate.run()`
- Usar `dynamic` como tipo en ninguna parte
- Mismo widget para ambas plataformas — adaptar siempre
- Dependencias directas entre features — prohibidas por defecto

---

## Troubleshooting

| Problema | Solución |
|----------|----------|
| `flutter analyze` con errores | Corregir todos antes de commit; `dart fix --apply` si es seguro |
| Conflictos de build_runner | `dart run build_runner build --delete-conflicting-outputs` |
| Feature acoplada a otra | Revisar `references/architecture-cpac.md` → refactorizar |
| Widget rebuild excesivo | Revisar `references/performance.md` → `const` + `context.select()` |
| Strings hardcoded en UI | Usar `AppLocalizations` → ver `references/l10n-environment.md` |

---

## Skills Relacionados

Si solo necesitas uno:
- `flutter-expert`: Solo arquitectura y lógica
- `ui-expert`: Solo diseño UI

---

## Repositorio

https://github.com/IvanMartinezLeon/FlutterCPAC