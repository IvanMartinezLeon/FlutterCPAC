# QA Checklist - FlutterCPAC

## Pre-Commit Checklist

Ejecuta **SIEMPRE** antes de cada commit:

```bash
flutter analyze && dart format .
```

---

## ✅ Análisis Estático

- [ ] `flutter analyze` → 0 errores
- [ ] `dart format .` → código formateado
- [ ] No hay `TODO` sin referencia a ticket
- [ ] No hay `FIXME` sin resolver

---

## ✅ Arquitectura

- [ ] Features aisladas (sin imports cruzados)
- [ ] Capas respetadas: presentation → domain → data
- [ ] No hay lógica de negocio en widgets
- [ ] Repositorios como abstracciones

---

## ✅ State Management

- [ ] Uso de `Cubit` o `Bloc` (no `setState` global)
- [ ] Estados inmutables (`copyWith` o `@freezed`)
- [ ] `Equatable` en estados y eventos
- [ ] `BlocBuilder`/`BlocListener` correctos

---

## ✅ UI / Diseño

- [ ] Tokens de `AppSpacing` (no hardcoded: 12, 20, etc.)
- [ ] Colores del `Theme` (no `Color(0xFF...)`)
- [ ] Touch targets ≥ 48px
- [ ] `TextScaler` respetado (no `TextScaler.noScaling`)
- [ ] Animaciones con `AppMotion`
- [ ] Constructores `const` donde sea posible

---

## ✅ Testing

- [ ] Tests unitarios para use cases
- [ ] Tests de cubit/bloc con `bloc_test`
- [ ] Cobertura ≥ 70%
- [ ] Tests pasando

---

## ✅ Documentación

- [ ] `doc/reports/log_report_YYYY_MM_DD.md` actualizado
- [ ] `doc/<feature>/SPEC.md` creado/actualizado
- [ ] `doc/<feature>/TODO.md` actualizado
- [ ] `doc/<feature>/TEST.md` actualizado

---

## ✅ Stores Compliance

### Google Play (DDA)
- [ ] Política de privacidad visible
- [ ] Información de contacto en app
- [ ] Sin contenido prohibido
- [ ] Permissions mínimas necesarias

### Apple App Store (ASRG)
- [ ] Info.plist con permisos necesarios
- [ ] App Tracking Transparency si hay analytics
- [ ] Metadatos precisos
- [ ] Sin funcionalidades ocultas

---

## Checklist por Tipo de Cambio

| Tipo | Checklist mínima |
|------|------------------|
| Feature | Arquitectura + UI + Docs + Test |
| Bug Fix | Análisis + Test passing |
| Refactor | Análisis + Test passing |
| UI Change | UI checklist + WCAG |
| Store Release | DDA/ASRG checklist completo |

---

## Siguiente

- [FAQ](FAQ) → Preguntas frecuentes
- [Home](Home) → Índice general
