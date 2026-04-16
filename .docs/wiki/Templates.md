# Templates - FlutterCPAC

## Plantillas Disponibles

Ubicación: `skills/flutter-cpac/templates/`

| Template | Uso | Descripción |
|----------|-----|-------------|
| `log_template.md` | Log de sesión | `doc/reports/log_report_YYYY_MM_DD.md` |
| `spec_template.md` | Feature | `doc/<feature>/SPEC.md` |
| `todo_template.md` | Feature | `doc/<feature>/TODO.md` |
| `test_template.md` | Feature | `doc/<feature>/TEST.md` |
| `feature_template.md` | Feature | `doc/<feature>/ARCHITECTURE.md` |
| `audit_template.md` | Auditoría CPAC | `doc/reports/audit_report_YYYY_MM_DD.md` |
| `dda_template.md` | Google Play | `doc/reports/dda_audit_report_YYYY_MM_DD.md` |
| `asrg_template.md` | Apple | `doc/reports/asrg_audit_report_YYYY_MM_DD.md` |

---

## Uso de Plantillas

### Log Report (por sesión)

```bash
# Crear nuevo log
cp skills/flutter-cpac/templates/log_template.md doc/reports/log_report_2024_01_15.md
```

### Feature Docs (por feature)

```bash
# Crear documentación de feature
mkdir -p doc/mi_feature
cp skills/flutter-cpac/templates/spec_template.md doc/mi_feature/SPEC.md
cp skills/flutter-cpac/templates/todo_template.md doc/mi_feature/TODO.md
cp skills/flutter-cpac/templates/test_template.md doc/mi_feature/TEST.md
```

---

## Estructura de Feature Docs

```
doc/
└── <feature_name>/
    ├── SPEC.md       # ¿Qué hace? Especificación
    ├── TODO.md       # Checklist de implementación
    ├── TEST.md       # Resultados de tests
    └── ARCHITECTURE.md  # Decisiones técnicas
```

---

## Nomenclatura

| Tipo | Formato | Ejemplo |
|------|---------|---------|
| Log | `log_report_YYYY_MM_DD.md` | `log_report_2024_01_15.md` |
| Feature | `SPEC.md`, `TODO.md`, `TEST.md` | `auth/SPEC.md` |
| Auditoría | `audit_report_YYYY_MM_DD.md` | `audit_report_2024_01_15.md` |
| DDA | `dda_audit_report_YYYY_MM_DD.md` | `dda_audit_report_2024_01_15.md` |
| ASRG | `asrg_audit_report_YYYY_MM_DD.md` | `asrg_audit_report_2024_01_15.md` |

---

## Siguiente

- [Scripts](Scripts) → Scripts de automatización
- [Home](Home) → Índice general
