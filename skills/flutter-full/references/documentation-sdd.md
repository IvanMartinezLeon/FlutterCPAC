# Documentación Automática y Spec-Driven Development (SDD)

Cuando el usuario pida **crear**, **modificar** o **corregir** una feature o bug, DEBES actualizar automáticamente la documentación SIN que el usuario lo pida explícitamente.

---

## Ciclo SDD

Cada modificación en una feature debe seguir este ciclo:

1. **SPEC Update:** Actualizar especificaciones en `doc/<nombre-feature>/`
2. **Code:** Implementar código
3. **Gen:** Ejecutar `flutter pub get` y generadores
4. **Analyze:** `flutter analyze` (0 errores)
5. **Test:** Ejecutar tests
6. **Memory Log:** Registrar en `PROJECT_LOG.md`

---

## Reglas Obligatorias

1. **Crear feature/bug:** Crear `doc/<nombre-feature>/SPEC.md` y `TODO.md`
2. **Modificar feature/bug:** Actualizar archivos existentes en `doc/<nombre-feature>/`
3. **Siempre que se modifique algo** en la feature, actualizar la documentación
4. **Siempre que se modifique algo**, actualizar `PROJECT_LOG.md` con tipo FEATURE o BUG

### Protocolo para features:
1. Verificar ubicación del proyecto (contiene pubspec.yaml)
2. Si no existe la carpeta `doc/<nombre-feature>/`, crearla
3. Crear/actualizar archivos con checkboxes para tareas
4. **Siempre:** Registrar cambios en `PROJECT_LOG.md` (tipo FEATURE o BUG)

---

## Plantilla SPEC.md

```markdown
# <Nombre Feature>

## Tipo
FEATURE | BUG

## Descripción
Breve descripción de la feature o bug.

## Estado
- [ ] En desarrollo
- [ ] Completado
- [ ] En testing
- [ ] Desplegado

## Funcionalidades / Problemas a resolver
- [ ] Funcionalidad 1
- [ ] Funcionalidad 2

## Dependencias
- Paquete 1

## UI/UX (si aplica)
Descripción de la interfaz esperada.

## Criterios de aceptación
- [ ] Criterio 1

## Tests
- [ ] Test unitario 1
- [ ] Test de widget 1

## Notas adicionales
-
```

---

## Plantilla TODO.md

```markdown
# TODO - <Nombre Feature>

## Fase 1: Setup
- [ ] Añadir dependencias
- [ ] Crear estructura de carpetas
- [ ] Configurar inyección de dependencias

## Fase 2: Modelos
- [ ] Crear modelo Entity
- [ ] Crear modelo DTO
- [ ] Crear mapper Entity ↔ DTO

## Fase 3: Capa de Datos
- [ ] Crear DataSource
- [ ] Crear Repository Interface
- [ ] Crear Repository Implementation

## Fase 4: Capa de Dominio
- [ ] Crear UseCase
- [ ] Definir Failures

## Fase 5: Presentación
- [ ] Crear Estado (State)
- [ ] Crear Cubit/Bloc
- [ ] Crear Widgets
- [ ] Crear Página

## Fase 6: Integración
- [ ] Registrar en DI
- [ ] Configurar rutas
- [ ] Testing

## Fase 7: QA
- [ ] Tests unitarios completados
- [ ] Tests de widget completados
- [ ] Análisis estático Passed
```

---

## PROJECT_LOG.md (Log Unificado)

**Propósito:** Mantener memoria continua del proyecto. Unifica decisiones técnicas, errores, soluciones y aprendizajes.

**Ubicación:** Raíz del proyecto (junto pubspec.yaml), **no** dentro de `doc/`.

**Tipos de entrada:** `FEATURE` | `BUG` | `DECISION`

### Protocolo del Agente

**Al inicio de cada sesión:**
1. Leer `PROJECT_LOG.md` si existe
2. Identificar aprendizajes relevantes a la tarea actual
3. Aplicar lecciones anteriores para evitar repetir errores

**Al finalizar cada sesión:**
1. Crear nueva entrada con tipo FEATURE, BUG o DECISION
2. Registrar errores si los hubo (tipo BUG)
3. Documentar soluciones aplicadas
4. Añadir aprendizajes clave
5. Actualizar deuda técnica pendiente

**Regla crítica:** Nunca repetir un error ya documentado en el log. Si ocurre, es prioridad máxima investigar por qué la solución anterior no fue efectiva.
