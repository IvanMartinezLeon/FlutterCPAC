# FAQ - FlutterCPAC

## General

### ¿Qué es FlutterCPAC?

FlutterCPAC es un sistema de contratos y automatización para proyectos Flutter que usa agentes de IA. Garantiza Clean Architecture, UI tokens, accesibilidad WCAG y cumplimiento con stores (Google Play + Apple).

---

### ¿Qué significa CPAC?

**C**ontract **P**rocess **A**utomated **C**lean Architecture. El nombre refleja su propósito: contratos rígidos que automatizan la arquitectura limpia.

---

### ¿Necesito experiencia previa en Flutter?

Recomendable tener conocimientos básicos de Flutter y Dart. CPAC te guía en arquitectura y calidad, pero no enseñando Flutter desde cero.

---

## Instalación

### ¿Cómo instalo el skill?

```bash
npx skills add IvanMartinezLeon/FlutterCPAC@flutter-cpac -g
```

O clona el repositorio y usa la carpeta directamente.

---

### ¿Funciona con mi IDE?

Sí. Compatible con:
- **Antigravity / OpenCode** (skill nativo)
- **Claude Code** (`claude code --skills flutter-cpac`)
- **Cursor** (Settings → Skills)
- **Windsurf** (Settings → Addon)
- **VS Code + Copilot** (carpeta `.claude` o `.cursor`)

---

## Arquitectura

### ¿Por qué BLoC/Cubit y no Riverpod?

CPAC está opinado hacia **BLoC/Cubit** por su:
- Separación clara de eventos/estados
- Testing sencillo con `bloc_test`
- Madurez y comunidad amplia

Riverpod está soportado como referencia pero no es el estándar CPAC.

---

### ¿Puedo tener múltiples features?

Sí. FlutterCPAC está diseñado para proyectos con **N features aisladas**.

```
lib/features/
├── auth/
├── home/
├── settings/
└── profile/
```

---

### ¿Qué pasa si borro una feature?

Debe funcionar sin romper otras. Por eso las features son independientes.

---

## Stores Compliance

### ¿Qué son DDA y ASRG?

- **DDA:** Google Play Developer Distribution Agreement
- **ASRG:** Apple App Store Review Guidelines

CPAC audita ambos para garantizar cumplimiento antes de publicar.

---

### ¿Debo auditar siempre?

Recomendable antes de cada release. La auditoría genera:
- `audit_report_*.md` — CPAC compliance
- `dda_audit_report_*.md` — Google Play
- `asrg_audit_report_*.md` — Apple

---

## Testing

### ¿Cuánta cobertura necesito?

**Mínimo:** 70%  
**Recomendado:** 80%+

Usa `./run_tests.sh` para verificar.

---

### ¿Qué tipos de test debo escribir?

| Tipo | Qué testear |
|------|-------------|
| Unit | Use cases, repositories |
| Bloc/Cubit | Estados y transiciones |
| Widget | Componentes UI críticos |
| Integration | Flujos completos |

---

## Documentación

### ¿Por qué tantos archivos de docs?

CPAC usa **Spec-Driven Development (SDD)**:
- `SPEC.md` → ¿Qué hace la feature?
- `TODO.md` → Checklist de implementación
- `TEST.md` → Resultados de tests

Esto permite que cualquier agente (o tú) coja el proyecto y entienda su estado.

---

### ¿Puedo borrar logs antiguos?

Sí. CPAC tiene regla de poda: archiva logs con más de 30 días y mantiene resumen.

---

## Scripts

### ¿Qué pasa si ejecuto un script en un proyecto no-Flutter?

Los scripts verifican el entorno. Si no hay `pubspec.yaml`, mostraran error y no executarán.

---

### ¿Puedo personalizar los scripts?

Sí. Los scripts son参考 y puedes adaptarlos a tu proyecto.

---

## Errores Comunes

### `flutter analyze` da errores

```bash
dart fix --apply  # Aplicar correcciones automáticas
flutter pub get   # Reinstala deps
```

---

### Tests fallan

1. Revisa mocks
2. Verifica estado inicial del cubit
3. Usa DevTools para debuggear

---

## Siguiente

- [Home](Home) → Índice general
- [QA Checklist](QA-Checklist) → Reglas de calidad
