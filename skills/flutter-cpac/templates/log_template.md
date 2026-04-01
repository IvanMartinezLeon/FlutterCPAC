# doc/reports/log_report_YYYY_MM_DD.md — Template

> Memoria continua del proyecto: decisiones técnicas, errores, soluciones y aprendizajes
> **Ubicación:** `doc/reports/`
> **Nomenclatura:** Un fichero por sesión/acción con formato `log_report_YYYY_MM_DD.md`

---

## Reglas Iniciales Obligatorias

- [ ] Mantenimiento de ficheros `log_report_YYYY_MM_DD.md` (ubicados en /doc/reports/)
- [ ] Regla de Poda: Si hay más de 10 ficheros log, archivar los antiguos en /doc/archive/
- [ ] Priorizar `AppLocalizations.of(context)!` sobre strings hardcoded
- [ ] Usar `const` constructors siempre que sea posible
- [ ] Nombres de clases en PascalCase, métodos y variables en camelCase
- [ ] Archivos con nombres en snake_case
- [ ] 0 errores en `flutter analyze` antes de cada commit
- [ ] **Nunca repetir un error ya documentado.**
- [ ] **Siempre crear un nuevo `doc/reports/log_report_YYYY_MM_DD.md`** tras cada modificación de feature
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

## 🏁 Session Handover (Resumen de Fin de Sesión)

> **Uso:** Rellenar este campo al finalizar una tarea o antes de cerrar el chat para que el siguiente agente no consuma tokens analizando todo desde cero.

- **Estado Actual**: [Punto en el que se ha quedado la tarea]
- **Archivos Modificados Clave**: [Ruta de los 2-3 archivos más importantes]
- **Próximos Pasos Pendientes**: [Lista corta de TODOs inmediatos]
- **Contexto Crítico**: [Cualquier aviso o "trampa" en el código detectada]
