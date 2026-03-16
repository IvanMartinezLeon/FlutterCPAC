# PROJECT_LOG.md

> Memoria continua del proyecto: decisiones técnicas, errores, soluciones y aprendizajes
> **Ubicación:** Raíz del proyecto (junto pubspec.yaml)

---

## Reglas Iniciales Obligatorias

- [ ] PROJECT_LOG.md en raíz del proyecto (no en doc/)
- [ ] Priorizar `AppLocalizations.of(context)!` sobre strings hardcoded
- [ ] Usar `const` constructors siempre que sea posible
- [ ] Nombres de clases en PascalCase, métodos y variables en camelCase
- [ ] Archivos con nombres en snake_case
- [ ] Evitar widget rebuilds innecesarios - usar `const` y `keys`
- [ ] 0 errores en `flutter analyze` antes de cada commit
- [ ] **Nunca repetir un error ya documentado.** Si ocurre, investigar por qué la solución anterior no fue efectiva.
- [ ] **Siempre actualizar PROJECT_LOG.md** tras cada modificación de feature

---

## Entradas de Log

> **Importante:** Este archivo debe estar en la **raíz del proyecto** ( junto con pubspec.yaml ), no en la carpeta doc/.

### [FEATURE/BUG/DECISION] - YYYY-MM-DD

**Acción:** FEATURE | BUG | DECISION

**Título:** 

**Descripción:** (qué se hizo)

**Solución:** (cómo se resolvió, especialmente para BUG)

**Aprendizaje:** (qué hemos aprendido - resumir en 1-2 frases)

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

---

## Ejemplo de Entrada FEATURE

### [FEATURE] - 2026-03-16

**Acción:** FEATURE

**Título:** Implementación de autenticación

**Descripción:** Sistema de login con email/password usando Firebase Auth

**Solución:** N/A (es feature)

**Aprendizaje:** Usar Either<Failure, T> desde RepositoryImpl para manejo de errores consistente

**Trabajo realizado:**
- Feature/Bug/Decisión trabajada: auth
- Archivos modificados: lib/features/auth/, pubspec.yaml
- Duración estimada: 4h

**Deuda técnica / Pendientes:**

- [ ] Tests unitarios para AuthRepository
- [ ] Implementar logout

---

## Ejemplo de Entrada BUG

### [BUG] - 2026-03-16

**Acción:** BUG

**Título:** LateInitializationError en EnvironmentConfig

**Descripción:** App crashea al iniciar en release

**Solución:** Mover `await EnvironmentConfig.initialize()` antes de `runApp()` en `main.dart`

**Aprendizaje:** Siempre inicializar configs asíncronas antes de cualquier lectura

**Trabajo realizado:**
- Feature/Bug/Decisión trabajada: 
- Archivos modificados: lib/config/environment.dart, lib/main.dart
- Duración estimada: 1h

**Errores encontrados:**

| # | Error | Causa Raíz | Solución | Aprendido |
|---|-------|------------|----------|-----------|
| 1 | `LateInitializationError` en `EnvironmentConfig` | `initialize()` no se llamó antes de leer `apiUrl` | Mover `await EnvironmentConfig.initialize()` antes de `runApp()` en `main.dart` | Siempre inicializar configs asíncronas antes de cualquier lectura |

**Deuda técnica / Pendientes:**

- [ ]

---

## Ejemplo de Entrada DECISION

### [DECISION] - 2026-03-16

**Acción:** DECISION

**Título:** Selección de gestor de estado

**Descripción:** Proyecto nuevo requiere elegir entre Riverpod, Bloc, GetX

**Solución:** Seleccionar Bloc/Cubit por madurez y documentación

**Aprendizaje:** Separar models/entities evita acoplamiento con json_serializable

**Trabajo realizado:**
- Feature/Bug/Decisión trabajada: 
- Archivos modificados: pubspec.yaml, flutter_expert_skill.md
- Duración estimada: 30min

**Deuda técnica / Pendientes:**

- [ ]

---

## Instrucciones de Uso

> **Ubicación:** Este archivo debe estar en la **raíz del proyecto** ( junto con pubspec.yaml ), NO en la carpeta doc/.

### Al inicio de cada sesión:
1. Leer `PROJECT_LOG.md`
2. Identificar aprendizajes relevantes a la tarea actual
3. Aplicar lecciones anteriores para evitar repetir errores

### Al finalizar cada sesión (o tras cada modificación de feature):
1. Crear nueva entrada con **Acción**: FEATURE, BUG o DECISION
2. Rellenar campos:
   - **Título**: nombre descriptivo
   - **Descripción**: qué se hizo
   - **Solución**: cómo se resolvió (especial para BUG)
   - **Aprendizaje**: resumen de 1-2 frases de lo aprendido
3. Registrar errores si los hubo (tipo BUG)
4. Añadir deuda técnica pendiente

---

## Comandos útiles

```bash
# Crear archivo si no existe (en raíz del proyecto, junto pubspec.yaml)
touch PROJECT_LOG.md

# Leer log actual
cat PROJECT_LOG.md

# Buscar errores específicos
grep -i "BUG" PROJECT_LOG.md

# Buscar por palabra clave
grep -i "bloc" PROJECT_LOG.md
```

---

## Integración con otros archivos

> **Ubicación de PROJECT_LOG.md:** Raíz del proyecto (junto pubspec.yaml)

| Archivo | Propósito | Ubicación |
|---------|-----------|-----------|
| `PROJECT_LOG.md` | Decisiones, errores y aprendizajes unificados | Raíz |
| `doc/<feature>/SPEC.md` | Especificación de feature | doc/ |
| `doc/<feature>/TODO.md` | Checklist de feature | doc/ |

Este archivo es el central. Consultar al inicio de cada nueva sesión. **Siempre actualizar tras cada modificación de feature.**