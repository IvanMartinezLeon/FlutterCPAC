# Flutter_CPAC

[![Flutter](https://img.shields.io/badge/Flutter-3.24-blue?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Dart](https://img.shields.io/badge/Dart-3.5-blue?logo=dart)](https://dart.dev)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)
[![Pipeline Status](https://img.shields.io/github/actions/workflow/status/IvanMartinezLeon/FlutterCPAC/flutter-ci.yml?branch=main&label=CI)](https://github.com/IvanMartinezLeon/FlutterCPAC/actions)

**Flutter_CPAC** es un sistema automatizado para crear, configurar, auditar, testear y deployar proyectos Flutter listos para producción. Utiliza contratos rígidos basados en Markdown para asegurar que cualquier agente de IA aplique Clean Architecture, inyecte Tokens de diseño estéticos, siga normativas de accesibilidad WCAG y cumpla con las guías de publicación de stores (Google Play DDA + Apple ASRG).

---

## 🤖 Agentes IA y Editores Soportados

Al ser un framework basado puramente en conocimiento Markdown y Scripts Bash, **es 100% universal**. Tienes soporte nativo garantizado en:
- **Agentes Nativos:** Antigravity, Claude Code, OpenCode.
- **IDEs con IA Integrada:** Cursor, Windsurf, Trae, Roo Code, GitHub Copilot.
- **Herramientas de Workflow:** CodeBuddy, Qoder, Gemini CLI.

---

## 📁 Estructura

```
FlutterCPAC/
├── commands/              # Comandos ejecutables (/crear, /auditar, /test...)
├── docs/wiki/             # Wiki del proyecto
├── skills/flutter-cpac/    # Skill principal
│   ├── references/        # Guías técnicas (arquitectura, UI, testing...)
│   ├── templates/         # Plantillas (SPEC, TODO, TEST, DDA, ASRG...)
│   ├── scripts/           # Bash scripts automatización
│   └── examples/          # Ejemplos de código
├── Makefile               # Atajos de comandos
├── .gitignore             # Optimizado para FlutterCPAC
└── readme.md              # Este archivo
```

---

## 🚀 Comandos Disponibles

| Comando | Descripción |
|---------|-------------|
| `/crear-flutter` | Crea proyecto Flutter con arquitectura CPAC + MASTER_THEME |
| `/auditar-flutter` | Auditoría completa: arquitectura, UI, DDA (Google Play), ASRG (Apple) |
| `/test-flutter` | Ejecuta tests y genera reportes con evidencias |
| `/refactor-flutter` | Refactorización masiva de deuda técnica |
| `/migrate-flutter` | Migración Flutter/Dart/paquetes a nuevas versiones |
| `/deploy-flutter` | Build y deploy a Google Play y App Store |

---

## ⚡ Makefile (Atajos Rápidos)

```bash
make help          # Ver todos los comandos
make install       # flutter pub get
make analyze       # flutter analyze
make format        # dart format .
make qa            # format + analyze
make test          # Ejecutar tests
make test-cov      # Tests con cobertura
make audit         # Auditoría CPAC
make build-apk     # Build APK release
make build-aab     # Build AAB para Play Store
make build-ios     # Build iOS
make build-all     # Build todas las plataformas
make deploy        # Checklist de deploy
make clean         # Limpiar builds y caches
make doctor        # flutter doctor
make ci            # QA + tests (pipeline CI)
make release       # QA + tests + build (pre-deploy)
```

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

---

## 🎯 Flujo de Desarrollo

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ /crear      │ ──▶ │ Desarrollo  │ ──▶ │ /refactor   │
│ Crea proyecto│     │ Features    │     │ Limpia deuda│
└─────────────┘     └──────┬──────┘     └──────┬──────┘
                           │                    │
                           ▼                    ▼
                    ┌─────────────┐     ┌─────────────┐
                    │ /test       │     │ make qa     │
                    │ Suite tests │     │ Analyze     │
                    └──────┬──────┘     └──────┬──────┘
                           │                    │
                           ▼                    ▼
                    ┌─────────────┐     ┌─────────────┐
                    │ /auditar    │     │ /migrate    │
                    │ Auditoría   │     │ Actualiza    │
                    └──────┬──────┘     └──────┬──────┘
                           │                    │
                           └────────┬───────────┘
                                    ▼
                             ┌─────────────┐
                             │ /deploy     │
                             │ A stores    │
                             └─────────────┘
```

---

## 🔎 Auditoría Completa

> ```
> /auditar-flutter
> ```

**Reportes generados:**
- `doc/reports/audit_report_YYYY_MM_DD.md` — Auditoría técnica CPAC
- `doc/reports/dda_audit_report_YYYY_MM_DD.md` — Cumplimiento Google Play DDA
- `doc/reports/asrg_audit_report_YYYY_MM_DD.md` — Cumplimiento Apple ASRG

---

## 🧪 Testing

> ```
> /test-flutter
> ```

**Reportes generados:**
- `doc/reports/test_report_YYYY_MM_DD.md` — Métricas y cobertura
- `doc/reports/test_evidence_YYYY_MM_DD.md` — Evidencias de fallos

---

## 🔧 Refactorización

> ```
> /refactor-flutter
> ```

Limpia automáticamente:
- Spacing hardcoded → `AppSpacing` tokens
- Colores hardcoded → `Theme`
- Durations hardcoded → `AppMotion`
- Extrae widgets repetidos
- Migra `StatefulWidget` → `Cubit`

---

## 🔄 Migración

> ```
> /migrate-flutter
> ```

Migraciones soportadas:
- Flutter SDK
- Dart
- Paquetes a null-safety
- Breaking changes de paquetes

---

## 🚀 Deploy

> ```
> /deploy-flutter
> ```

### Pre-requisitos

| Store | Requisitos |
|-------|------------|
| **Google Play** | Cuenta Developer ($25), keystore, service_account.json |
| **App Store** | Apple Developer Account, certificados |

### Builds

```bash
make build-aab     # Android (Play Store)
make build-ios     # iOS (App Store)
make build-all     # Todas las plataformas
```

---

## 📚 Documentación

| Tipo | Ubicación |
|------|-----------|
| Wiki | `docs/wiki/` |
| SKILL | `skills/flutter-cpac/SKILL.md` |
| Comandos | `commands/` |
| Templates | `skills/flutter-cpac/templates/` |
| Reports | `doc/reports/` |

---

## ⚙️ Scripts Bash

| Script | Descripción |
|--------|-------------|
| `scripts/init_project.sh` | Inicializar proyecto |
| `scripts/run_tests.sh` | Tests con cobertura |
| `scripts/changelog.sh` | Generar CHANGELOG.md |

---

## 📋 Contrato CPAC

Antes de cada commit:

```bash
flutter analyze && dart format .
```

**Reglas:**
- 0 errores en `flutter analyze`
- Nunca repetir error ya documentado
- Actualizar `doc/reports/log_report_*.md` tras cada cambio
- Mantener cobertura ≥ 70%

---

## 🌐 Wiki

Documentación extendida disponible en `docs/wiki/`:
- [Home](docs/wiki/Home.md)
- [Arquitectura](docs/wiki/Arquitectura.md)
- [Commands](docs/wiki/Commands.md)
- [Templates](docs/wiki/Templates.md)
- [Scripts](docs/wiki/Scripts.md)
- [QA Checklist](docs/wiki/QA-Checklist.md)
- [FAQ](docs/wiki/FAQ.md)

---

## 📂 Más Información

- [SKILL.md](skills/flutter-cpac/SKILL.md)
- [Comandos](commands/)
- [Repositorio](https://github.com/IvanMartinezLeon/FlutterCPAC)
