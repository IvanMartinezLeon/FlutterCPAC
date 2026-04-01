---
description: Audita un proyecto Flutter existente contra las reglas del Contrato CPAC
agent: *
---

Ejecuta una auditoría táctica y arquitectónica del código del proyecto Flutter actual para comprobar su nivel de cumplimiento respecto a las rígidas normas del Contrato FlutterCPAC.

### FASE 1: Preparación
1. **Lectura de Mandatos (OBLIGATORIO):**
   - Evalúa `skills/flutter-cpac/SKILL.md` para memorizar la arquitectura modular por features.
   - Evalúa `skills/flutter-cpac/references/ui-adaptive.md` para las reglas estrictas de Accesibilidad (WCAG 2.2), Spacing y Motion.
   - Opcionalmente echa un ojo rápido a los ficheros `doc/reports/log_report_*.md` para ver de qué trata.

### FASE 2: Escaneo Técnico
2. **Análisis Estático Nativo:**
   - Ejecuta comando: `flutter analyze`
   - Si la salida arroja errores, documéntalos como el Nivel 1 de deuda técnica.

3. **Auditoría de Clean Architecture:**
   - Explora la carpeta `lib/`. Asegúrate de que las funcionalidades están contenidas estrictamente bajo `lib/features/` o el estándar pactado.
   - Denuncia cualquier importación cruzada entre features (Ej: `feature_A` importando un modelo de la carpeta de código de `feature_B`).
   - Denuncia si algún Widget visual (Capa de Presentación) ataca directamente a un endpoint, a SQLite, o instancia un `Dio` / `http` sin pasar por un State Manager (Bloc/Cubit).

### FASE 3: Auditoría UX / UI Pro Max
4. **Validación Visual Normativa:**
   - Escanea la presencia de "hardcoded spacing": Buscar código como `EdgeInsets.all(12)` o `SizedBox(height: 20)`. Exige que se cambien a `AppSpacing.md` o múltiplos de 4 reglamentarios.
   - Escanea violaciones de color: Busca constructores explícitos `Color(0xFF...)` en mitad del código de features en vez de beber de `Theme.of(context).colorScheme`.
   - Busca violaciones de Accesibilidad (WCAG): Fíjate si los Touch Targets (IconButtons) miden menos de 48px, o si algún agente rebelde ha metido el infame comando `TextScaler.noScaling` (lo cual quita lupa a la gente con deficiencia visual).
   - Busca duraciones hardcodeadas `Duration(milliseconds: 200)` en vez de usar la normativa centralizada `AppMotion`.

### FASE 4: Veredicto y Persistencia
5. **Genera AMBOS ficheros de forma simultánea (OBLIGATORIO):**

   **Fichero 1 — Reporte de Auditoría:** `doc/reports/audit_report_YYYY_MM_DD.md`
   - Usa la plantilla `skills/flutter-cpac/templates/audit_template.md`
   - Rellena todas las secciones con los hallazgos detectados

   **Fichero 2 — Log de la sesión:** `doc/reports/log_report_YYYY_MM_DD.md`
   - Usa la plantilla `skills/flutter-cpac/templates/log_template.md`
   - Añade entrada de tipo **AUDIT** con:
     - **Acción:** AUDIT
     - **Título:** Auditoría del proyecto - YYYY-MM-DD
     - **Descripción:** Resumen breve del alcance
     - **Hallazgos principales:** 3-5 problemas más relevantes
     - **Reporte completo:** Ruta a `doc/reports/audit_report_YYYY_MM_DD.md`

6. **Resumen en Chat:** Muestra un resumen ejecutivo de los 3 puntos más urgentes detectados.

7. **PREGUNTA al programador** si desea que un agente ejecute un bloque de refactorización "Auto-Fix" (limpiando spacing, inyectando constants, arreglando imports...) sobre todos los hallazgos.
