# Audit Report Template

> **Ruta:** `doc/reports/audit_report_YYYY_MM_DD.md`
> **Fecha de Auditoría:** YYYY-MM-DD
> **Proyecto:** [Nombre del Proyecto]
> **Auditor:** [Nombre del Agente/IA]
> **Rama Auditada:** [Nombre de la rama]

---

## 📊 Resumen Ejecutivo

| Métrica | Valor |
|---------|-------|
| Total de Hallazgos | 0 |
| ❌ Críticos | 0 |
| ⚠️ Advertencias | 0 |
| ✅ Cumplimiento General | 0% |

---

## ❌ Errores Críticos (flutter analyze)

> Errores que impiden la compilación o violan el contrato CPAC de forma grave.

| # | Archivo | Línea | Error | Estado |
|---|---------|-------|-------|--------|
| 1 | | | | Pendiente |

---

## 🏗️ Fallos Arquitectónicos

> Violaciones de Clean Architecture: imports cruzados, capas mezcladas, etc.

| # | Tipo | Descripción | Archivo(s) Afectados | Recomendación |
|---|------|-------------|---------------------|---------------|
| 1 | | | | |

---

## 🎨 Deuda de UI/UX

> Spacing hardcoded, colores fuera de tokens, motion UI no centralizada.

| # | Tipo | Descripción | Archivo(s) Afectados | Recomendación |
|---|------|-------------|---------------------|---------------|
| 1 | Spacing Hardcoded | | | Usar `AppSpacing` |
| 2 | Color Hardcoded | | | Usar `Theme.of(context).colorScheme` |
| 3 | Motion Hardcoded | | | Usar `AppMotion` |
| 4 | Token No Usado | | | |

---

## ⚖️ Cumplimiento de Accesibilidad (WCAG 2.2)

> Touch targets, escalado de texto, contraste, semántica.

| # | Criterio | Descripción | Archivo(s) Afectados | Recomendación |
|---|----------|-------------|---------------------|---------------|
| 1 | Touch Target (≥48px) | | | Envolver en `SizedBox` o `ConstrainedBox` |
| 2 | Text Scaling | | | No usar `TextScaler.noScaling` |
| 3 | Semántica | | | Añadir `Semantics` o `ExcludeSemantics` |
| 4 | Contraste | | | Verificar ratio ≥ 4.5:1 |

---

## 📈 Historial de Cumplimiento

| Fecha | Cumplimiento | Críticos | Advertencias | Notas |
|-------|-------------|----------|--------------|-------|
| YYYY-MM-DD | 0% | 0 | 0 | Auditoría inicial |

---

## 🏁 Plan de Acción

### Prioridad Alta (Resolver antes del próximo commit)

- [ ] 
- [ ] 

### Prioridad Media (Resolver en el sprint actual)

- [ ] 
- [ ] 

### Prioridad Baja (Mejora continua)

- [ ] 
- [ ] 

---

## 📝 Notas Adicionales

> Contexto adicional, observaciones o decisiones tomadas durante la auditoría.

---

*Generado automáticamente por FlutterCPAC Audit System*
