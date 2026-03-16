---
name: flutter-full
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
- `scripts/init_project.sh` - Script de creación de proyectos
- `templates/` - Plantillas de documentación
- `examples/` - Ejemplos de referencia
- `references/` - Material de deep-dive por tema

---

## Cuándo Usar Este Skill

- Desarrollo completo de aplicaciones Flutter
- Proyectos que requieren UI nativa en ambas plataformas (Material + Cupertino)
- Arquitectura CPAC + diseño UI en el mismo flujo
- Creación de nuevos proyectos desde cero
- Implementación de features con Clean Architecture

---

## Core Workflow

1. **SPEC Update** — Actualizar `doc/<feature>/SPEC.md` y `TODO.md`
   - Si no existen: crearlos usando plantillas de `templates/`
2. **Code** — Implementar código siguiendo Clean Architecture (data/domain/presentation)
   - Si arquitectura no está clara: cargar `references/architecture-cpac.md` y `references/project-structure.md`
3. **Gen** — Ejecutar `flutter pub get` y generadores (`build_runner`, `l10n`)
   - Si hay conflictos de generación: `dart run build_runner build --delete-conflicting-outputs`
4. **Analyze** — `flutter analyze` (0 errores obligatorio)
   - Si hay errores: corregir todos antes de continuar; re-ejecutar hasta limpio
5. **Test** — Ejecutar `flutter test --coverage`
   - Si tests fallan: revisar widget tree con DevTools, añadir tests faltantes
6. **Memory Log** — Registrar en `PROJECT_LOG.md` (tipo FEATURE, BUG o DECISION)

---

## Reference Guide

Cargar guía detallada según contexto:

| Tema | Referencia | Cargar cuando... |
|------|-----------|-------------------|
| Arquitectura CPAC | `references/architecture-cpac.md` | Límites de features, contrato de arquitectura, eliminabilidad |
| Estructura | `references/project-structure.md` | Setup de proyecto, naming, organización de carpetas |
| Cubit/Bloc | `references/bloc-cubit-state.md` | Gestión de estado, BlocBuilder, BlocListener |
| Errores | `references/error-handling.md` | Either<Failure,T>, mapeo de errores, fpdart |
| Documentación | `references/documentation-sdd.md` | Spec-Driven Development, PROJECT_LOG, SPEC.md |
| UI Adaptativa | `references/ui-adaptive.md` | Material Design 3, Cupertino, widgets adaptativos, spacing |
| Testing | `references/testing.md` | Tests unitarios, de widget, bloc_test, cobertura |
| Networking | `references/networking-dio.md` | Dio, interceptores, capa de red |
| Rendimiento | `references/performance.md` | Optimización, DevTools, green software |
| L10n/Entornos | `references/l10n-environment.md` | Localización, internacionalización, archivos .env |
| Crear Proyecto | `references/createproject.md` | Creación de proyecto desde cero, flujo completo paso a paso |

---

## Scripts

| Script | Descripción | Uso |
|--------|-------------|-----|
| `scripts/init_project.sh` | Inicialización de proyecto Flutter con estructura CPAC | `./scripts/init_project.sh` (interactivo) o `--simple` / `--with-ai` |

---

## Templates

| Template | Descripción |
|----------|-------------|
| `templates/project_log_template.md` | Plantilla para PROJECT_LOG.md |
| `templates/spec_template.md` | Plantilla SPEC.md para features |
| `templates/todo_template.md` | Plantilla TODO.md para features |
| `templates/feature_template.md` | Plantilla ARCHITECTURE.md para features |

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

---

## Constraints

### ✅ MUST DO
- Constructores `const` en cada widget estático
- `BlocBuilder` / `BlocListener` / `BlocConsumer` para consumo de estado
- Keys en items de lista y widgets reordenados dinámicamente
- `Either<Failure, T>` desde repositorios
- `flutter analyze && dart format .` antes de cada commit
- Siempre actualizar PROJECT_LOG.md tras cada modificación
- Siempre actualizar SPEC.md y TODO.md de la feature
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