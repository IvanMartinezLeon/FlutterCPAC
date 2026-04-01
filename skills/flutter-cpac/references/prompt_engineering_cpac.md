# 🎯 Prompt Engineering for FlutterCPAC

Guía de prompts de alta eficiencia diseñados para minimizar el consumo de tokens y maximizar la precisión técnica en el ecosistema CPAC.

---

## 🏗️ Creación de Features (SDD)

**Prompt sugerido:**
> "Crea una nueva feature llamada `[NAME]`. 
> 
> Primero, genera `doc/[NAME]/SPEC.md` y `TODO.md` basándote en la descripción: `[DESCRIPCION]`. 
> Aplica Clean Architecture (data/domain/presentation). 
> Usa BLoC/Cubit para el estado. 
> Importante: Usa los tokens de `lib/config/app_theme_tokens.dart` para todo el UI. 
> No leas carpetas de plataforma."

---

## 🐞 Depuración de Errores

**Prompt sugerido:**
> "Analiza este error de runtime: `[STACK_TRACE]`.
> 
> Busca la causa raíz en `lib/features/` usando `grep`. 
> Prioriza la revisión del BLoC y el mapeo de errores en la capa `data`. 
> Antes de corregir, revisa `doc/reports/log_report_*.md` para ver si este error ya ocurrió y cómo se solucionó."

---

## 🛠️ Refactorización de UI

**Prompt sugerido:**
> "Refactoriza el widget `[WIDGET_NAME]`. 
> 
> Objetivo: Eliminar todos los valores hardcoded (colors, sizes, paddings). 
> Acción: Sustituirlos por tokens de `AppThemeTokens`. 
> Extrae sub-widgets complejos a clases separadas fuera de `build()`. 
> No leas archivos fuera de `lib/features/[FEATURE]` ni de plataforma."

---

## 💡 Tips de Ahorro de Tokens

1. **Lectura por capas**: "Lee solo el `domain/entities` de la feature para entender el modelo, no leas la UI todavía."
2. **Búsqueda quirúrgica**: "Usa `grep` para encontrar dónde se instancia `Dio` en lugar de listar toda la carpeta `core/`."
3. **Resumen de sesión**: "Al terminar, escribe un `Session Handover` en el Log con los 3 archivos clave que has tocado y qué queda pendiente."
4. **Ignorar binarios**: "Nunca intentes leer archivos `.sh`, `.png` o `.lock` completos a menos que sea estrictamente necesario."

---

## 🧠 Relevo de Agente (Handover)

Cuando sientas que el contexto está muy lleno, usa este prompt para "limpiar" la sesión:

> "Haz un resumen de lo avanzado en esta sesión en `doc/reports/log_report_YYYY_MM_DD.md`. Asegúrate de listar el 'Current State' de la arquitectura. Una vez hecho, indica al usuario que la sesión puede ser reiniciada para ahorrar tokens."
