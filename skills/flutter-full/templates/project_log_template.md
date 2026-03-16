# PROJECT_LOG.md — Template

> Memoria continua del proyecto: decisiones técnicas, errores, soluciones y aprendizajes
> **Ubicación:** Raíz del proyecto (junto pubspec.yaml)

---

## Reglas Iniciales Obligatorias

- [ ] PROJECT_LOG.md en raíz del proyecto (no en doc/)
- [ ] Priorizar `AppLocalizations.of(context)!` sobre strings hardcoded
- [ ] Usar `const` constructors siempre que sea posible
- [ ] Nombres de clases en PascalCase, métodos y variables en camelCase
- [ ] Archivos con nombres en snake_case
- [ ] 0 errores en `flutter analyze` antes de cada commit
- [ ] **Nunca repetir un error ya documentado.**
- [ ] **Siempre actualizar PROJECT_LOG.md** tras cada modificación de feature
- [ ] **Siempre actualizar SPEC.md y TODO.md** de la feature al modificar algo

---

## Entradas de Log

### [FEATURE/BUG/DECISION] - YYYY-MM-DD

**Acción:** FEATURE | BUG | DECISION

**Título:**

**Descripción:** (qué se hizo)

**Solución:** (cómo se resolvió, especialmente para BUG)

**Aprendizaje:** (resumir en 1-2 frases)

**Trabajo realizado:**
- Feature/Bug/Decisión trabajada:
- Archivos modificados:
- Duración estimada:

**Errores encontrados (solo BUG):**

| # | Error | Causa Raíz | Solución | Aprendido |
|---|-------|------------|----------|-----------|
| 1 | | | | |

**Deuda técnica / Pendientes:**

- [ ]

---
