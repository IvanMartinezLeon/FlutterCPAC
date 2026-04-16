# Scripts - FlutterCPAC

## Scripts Disponibles

Ubicación: `skills/flutter-cpac/scripts/`

| Script | Descripción | Uso |
|--------|-------------|-----|
| `init_project.sh` | Inicializar proyecto Flutter | `./init_project.sh [--simple\|--with-ai]` |
| `run_tests.sh` | Tests con cobertura | `./run_tests.sh` |
| `changelog.sh` | Generar CHANGELOG.md | `./changelog.sh [version]` |

---

## init_project.sh

### Opciones

```bash
# Modo interactivo (default)
./init_project.sh

# Modo simple (sin IA)
./init_project.sh --simple

# Modo con guía IA
./init_project.sh --with-ai
```

### Lo que hace

1. Crea proyecto Flutter
2. Configura multi-entorno (.env)
3. Configura i18n (ES/EN)
4. Crea estructura de carpetas
5. Genera `doc/reports/log_report_YYYY_MM_DD.md`
6. Ejecuta `flutter pub get`
7. Ejecuta `flutter analyze`

---

## run_tests.sh

### Uso

```bash
./run_tests.sh
```

### Lo que hace

1. Verifica entorno Flutter
2. Ejecuta `flutter test --coverage --reporter expanded`
3. Genera `doc/reports/test_report_YYYY_MM_DD.md`
4. Genera `doc/reports/test_evidence_YYYY_MM_DD.md` (si hay fallos)
5. Actualiza `TEST.md` de cada feature
6. Registra en log

### Salida

```
Tests: X executed | X passed | X failed | X skipped
Cobertura: XX%
Reportes: doc/reports/test_report_YYYY_MM_DD.md
```

---

## changelog.sh

### Uso

```bash
# Generar con versión default (1.0.0)
./changelog.sh

# Generar con versión específica
./changelog.sh 2.1.0
```

### Lo que hace

1. Escanea `doc/reports/log_report_*.md`
2. Extrae:
   - Features añadidas
   - Bugs corregidos
   - Auditorías realizadas
   - Tests ejecutados
3. Genera `CHANGELOG.md`

### Formato de Salida

```markdown
## [2.1.0] - 2024-01-15

### Added
- Feature auth login
- Feature home dashboard

### Fixed
- Bug in user profile

### Changed
- Updated project documentation
```

---

## Siguiente

- [QA Checklist](QA-Checklist) → Reglas de calidad
- [FAQ](FAQ) → Preguntas frecuentes
