# Flutter_CPAC

[![Flutter](https://img.shields.io/badge/Flutter-3.24-blue?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Dart](https://img.shields.io/badge/Dart-3.5-blue?logo=dart)](https://dart.dev)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)
[![Pipeline Status](https://img.shields.io/github/actions/workflow/status/IvanMartinezLeon/FlutterCPAC/flutter-ci.yml?branch=main&label=CI)](https://github.com/IvanMartinezLeon/FlutterCPAC/actions)

**Flutter_CPAC** es un sistema automatizado para crear, configurar, auditar y testear proyectos Flutter listos para la pre-producción. Utiliza contratos rígidos basados en Markdown para asegurar que cualquier agente de IA aplique Clean Architecture, inyecte Tokens de diseño estéticos, siga normativas de accesibilidad WCAG y cumpla con las guías de publicación de stores (Google Play DDA + Apple ASRG).

### 🤖 Agentes IA y Editores Soportados

Al ser un framework basado puramente en conocimiento Markdown y Scripts Bash, **es 100% universal**. Tienes soporte nativo garantizado en:
- **Agentes Nativos:** Antigravity, Claude Code, OpenCode.
- **IDEs con IA Integrada:** Cursor, Windsurf, Trae, Roo Code, GitHub Copilot.
- **Herramientas de Workflow:** CodeBuddy, Qoder, Gemini CLI.

---

## 📁 Estructura

```
FlutterCPAC/
├── commands/          # Comandos ejecutables por agentes (auditar, crear, test...)
├── skills/           # Skill principal flutter-cpac con referencias completas
│   └── flutter-cpac/
│       ├── references/  # Guías técnicas (arquitectura, UI, testing...)
│       ├── templates/   # Plantillas (SPEC, TODO, TEST, LOG...)
│       ├── scripts/     # Bash scripts automatización
│       └── examples/    # Ejemplos de código
└── readme.md         # Este archivo
```

---

## 🚀 Comandos Disponibles

| Comando | Descripción |
|---------|-------------|
| `/crear-flutter` | Crea proyecto Flutter con arquitectura CPAC + MASTER_THEME |
| `/auditar-flutter` | Auditoría completa: arquitectura, UI, DDA (Google Play), ASRG (Apple) |
| `/test-flutter` | Ejecuta tests y genera reportes con evidencias |

---

## 🔎 Auditar un Proyecto Existente

Si aplicaste la arquitectura hace semanas y quieres pasar un control de calidad (o estás asumiendo código legado), pídele a la IA:

> ```
> /auditar-flutter
> ```

La inteligencia artificial auditará las carpetas escaneando el código en busca de: 
- **Arquitectura:** Violaciones de Clean Architecture (dependencias cruzadas, imports prohibidos)
- **UI:** Colores/Spacing hardcoded vs tokens de `AppSpacing`, Touch Targets <48px, `TextScaler.noScaling`
- **Accesibilidad:** WCAG 2.2, motion, legibilidad
- **Google Play DDA:** Políticas de contenido, permisos, privacidad, takedowns, garantías
- **Apple ASRG:** Safety, Performance, Software Requirements, Business, Design, Legal

**Reportes generados:**
- `doc/reports/audit_report_YYYY_MM_DD.md` — Auditoría técnica CPAC
- `doc/reports/dda_audit_report_YYYY_MM_DD.md` — Cumplimiento Google Play DDA
- `doc/reports/asrg_audit_report_YYYY_MM_DD.md` — Cumplimiento Apple ASRG

---

## 🧪 Testear un Proyecto

Ejecuta suite completa de tests con análisis de resultados:

> ```
> /test-flutter
> ```

La IA ejecutará:
- `flutter test --reporter expanded` — Suite completa
- `flutter test --coverage` — Análisis de cobertura
- Tests por tipo: Unit, Widget, Bloc, Integration, Golden

**Reportes generados:**
- `doc/reports/test_report_YYYY_MM_DD.md` — Métricas y cobertura
- `doc/reports/test_evidence_YYYY_MM_DD.md` — Evidencias de fallos

---

## 📦 Instalación

### Opción 1: Como Skill (Recomendado)

```bash
# Instalar como skill global para tu agente
npx skills add IvanMartinezLeon/FlutterCPAC@flutter-cpac -g

# O clonar directamente el repositorio
git clone https://github.com/IvanMartinezLeon/FlutterCPAC.git
```

### Opción 2: Por Proyecto (Rígido)

```bash
# Copiar skill al proyecto específico
mkdir -p .agents/skills
git clone https://github.com/IvanMartinezLeon/FlutterCPAC.git .agents/skills/flutter-cpac
```

### Configuración por Agente

| Agente | Configuración |
|--------|---------------|
| **Antigravity/OpenCode** | Elige "FlutterCPAC" como skill activo |
| **Claude Code** | `claude code --skills flutter-cpac` |
| **Cursor** | Settings → Skills → Añadir FlutterCPAC |
| **VS Code + Copilot** | Renombra carpeta a `.claude` o `.cursor` |
| **Windsurf** | Settings → Addon → FlutterCPAC |

### Verificar Instalación

Una vez instalado, escribe en el chat:

```
/crear-flutter
```

Deberías ver que el agente responde con el flujo de creación de proyecto.

---

## 🎨 Crear un Proyecto Flutter

Una vez tengas alojada la Skill (o simplemente abriendo la carpeta de este repositorio en el IDE), escribe a la IA en el chat:

> ```
> /crear-flutter
> ```

La inteligencia empezará la cadena para inyectar un ecosistema con:
- Arquitectura Clean / Bloc/Cubit base automatizada
- Internacionalización con `AppLocalizations` (ES/EN) + `DotEnv` multi-entorno
- MASTER_THEME.md con UI tokens y paletas específicas según el sector (Banca, Retail, Clínicas...)

---

## Características

- **Theming por Sector Propulsado por IA**: Inyección al crear el proyecto de un `MASTER_THEME.md` con UI tokens y paletas de color en función de la industria dada.
- **Auditorías de Stores**: Verificación automática de cumplimiento Google Play DDA y Apple App Store Review Guidelines
- **Regulaciones de Motion UI y Acceso**: Curvas de animación y tiempos bloqueados (normativa M3 UX Pro).
- **Tres entornos pre-configurados**: Debug, Profile y Release con archivos `.env` totalmente integrados.
- **Memorias Continuas IA**: Generación intrínseca de `doc/reports/log_report_YYYY_MM_DD.md` con sistema de **Session Handover**.
- **Protocolo CEP (Eficiencia de Contexto)**: Reglas estrictas de poda de directorios para ahorrar hasta un 60% en costos de consulta.
- **Prompt Engineering Optimizado**: Guía de prompts quirúrgicos para creación de features, debugging y refactoring.
- **Clean Architecture Pura**: Estructura hermética de capas con separación de presentación, dominio y datos.
- **Contrato CPAC**: Exigen que antes de cada commit obligatoriamente se pase un `flutter analyze`.

---

## Comandos útiles del proyecto

```bash
# Verificar entorno
flutter doctor

# Instalar dependencias
flutter pub get

# Generar localizaciones
flutter gen-l10n

# Análisis de código (obligatorio antes de commit)
flutter analyze

# Formatear código
dart format .

# Ejecutar tests con cobertura
flutter test --coverage
```

---

## Estructura del Proyecto

El proyecto sigue una arquitectura limpia con separación de características:

```
lib/
├── core/                      # Configuraciones globales
│   ├── error/                 # Fallos globales y excepciones
│   ├── network/               # Configuración de Dio e interceptores
│   ├── di/                    # Inyección de dependencias (GetIt)
│   └── usecases/              # Clase base abstracta UseCase
├── features/                  # Módulos por funcionalidad
│   └── [feature]/
│       ├── data/              # Fuentes de datos y modelos
│       ├── domain/            # Entidades y lógica de negocio
│       └── presentation/      # UI y estado (Cubits, Pages, Widgets)
└── main.dart                  # Configuración y arranque
```

---

## Documentos del Proyecto

| Archivo | Propósito |
|---------|-----------|
| `doc/reports/log_report_YYYY_MM_DD.md` | Decisiones, errores y aprendizajes unificados (un fichero por sesión/acción) |
| `doc/reports/` | Historial de reportes de auditoría, tests y logs |
| `doc/<feature>/SPEC.md` | Especificación de funcionalidad (SDD) |
| `doc/<feature>/TODO.md` | Checklist de estado de la funcionalidad |
| `doc/<feature>/TEST.md` | Resultados de tests y cobertura |

---

## Reglas de Calidad (Contrato CPAC)

Antes de cada commit, ejecuta:

```bash
flutter analyze && dart format .
```

**Nunca repetir un error ya documentado en `doc/reports/log_report_*.md`**

---

## Más Información

- Documentación completa: [skills/flutter-cpac/SKILL.md](./skills/flutter-cpac/SKILL.md)
- Workflow de creación: [commands/crear-flutter.md](./commands/crear-flutter.md)
- Repositorio: https://github.com/IvanMartinezLeon/FlutterCPAC
