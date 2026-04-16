# Commands - FlutterCPAC

## Comandos Disponibles

| Comando | Descripción | Archivo |
|---------|-------------|---------|
| `/crear-flutter` | Crear proyecto Flutter | [commands/crear-flutter.md](../../commands/crear-flutter.md) |
| `/auditar-flutter` | Auditoría completa | [commands/auditar-flutter.md](../../commands/auditar-flutter.md) |
| `/test-flutter` | Ejecutar tests | [commands/test-flutter.md](../../commands/test-flutter.md) |

---

## Flujo Típico

```
┌─────────────┐
│ /crear     │ → Genera proyecto base
└─────┬──────┘
      │
      ▼
┌─────────────┐
│ Desarrollo  │ → Implementa features
└─────┬──────┘
      │
      ▼
┌─────────────┐
│ /test       │ → Verifica tests
└─────┬──────┘
      │
      ▼
┌─────────────┐
│ /auditar    │ → Valida calidad
└─────┬──────┘
      │
      ▼
   Release
```

---

## Detalle de Comandos

### /crear-flutter

1. Clona template FlutterCPAC
2. Configura:
   - Arquitectura Clean
   - Bloc/Cubit
   - Internacionalización (ES/EN)
   - Multi-entorno (.env)
   - MASTER_THEME.md

### /auditar-flutter

Audita en 4 fases:
1. **FASE 2:** `flutter analyze` + Clean Architecture
2. **FASE 3:** UI/WCAG compliance
3. **FASE 3.5:** Google Play DDA
4. **FASE 3.6:** Apple ASRG

Genera:
- `doc/reports/audit_report_YYYY_MM_DD.md`
- `doc/reports/dda_audit_report_YYYY_MM_DD.md`
- `doc/reports/asrg_audit_report_YYYY_MM_DD.md`

### /test-flutter

1. Ejecuta `flutter test --coverage`
2. Genera reportes:
   - `doc/reports/test_report_YYYY_MM_DD.md`
   - `doc/reports/test_evidence_YYYY_MM_DD.md`

---

## Scripts Bash

| Script | Descripción |
|--------|-------------|
| `scripts/init_project.sh` | Inicializar proyecto |
| `scripts/run_tests.sh` | Tests con cobertura |
| `scripts/changelog.sh` | Generar CHANGELOG.md |

---

## Siguiente

- [Templates](Templates) → Plantillas de documentación
- [QA Checklist](QA-Checklist) → Reglas de calidad
