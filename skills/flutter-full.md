---
name: flutter-full
description: "Skill completo de Flutter: arquitectura CPAC, Clean Architecture, gestión de estado con BLoC/Cubit, UI adaptativa (Material Design + Cupertino), documentación automática y Spec-Driven Development. Combina flutter-expert y ui-expert en un solo skill."
tools: Read, Write, Edit, Bash, Glob, Grep
---

# Flutter Full Skill

Este skill combina **flutter-expert** y **ui-expert** para un desarrollo Flutter completo.

> **Contenido:** Este skill incluye todas las capacidades de flutter-expert (arquitectura CPAC, Clean Architecture, documentación automática, PROJECT_LOG) Y ui-expert (Material Design 3, Cupertino, widgets adaptativos).

---

## Cuándo usar este skill

- Desarrollo completo de aplicaciones Flutter
- Proyectos que requieren UI nativa en ambas plataformas
- Necesitas arquitectura + diseño UI en el mismo flujo

---

## Activar skills combinados

Al activar este skill, tienes acceso a:

### De flutter-expert:
- Arquitectura CPAC (Cross-Platform Architecture Contract)
- Clean Architecture con features aisladas
- Gestión de estado con Cubit/Bloc
- Documentación automática (SPEC.md, TODO.md, PROJECT_LOG.md)
- Spec-Driven Development (SDD)
- Manejo de errores con Either<Failure, T>
- Inyección de dependencias con GetIt

### De ui-expert:
- Material Design 3 para Android
- Cupertino Design para iOS
- Widgets adaptativos por plataforma
- Sistema de spacing unificado
- Responsive design con breakpoints

---

## Idioma de Comunicación

**Regla obligatoria:** Siempre responde en **castellano**.

- ✅ Responde en castellano
- ✅ Código en inglés (clases, variables, funciones)
- ✅ Términos técnicos en inglés (Widget, Cubit, Repository, Either)

---

## Reglas de Oro

### Arquitectura CPAC
- Features aisladas bajo `lib/features/<nombre>/`
- Cada feature: data/domain/presentation
- Composition Root en `lib/core/di/`
- Dependencias entre features prohibidas por defecto
- PROJECT_LOG.md en raíz del proyecto

### Documentación Automática
- **Siempre** actualizar SPEC.md y TODO.md al modificar una feature
- **Siempre** actualizar PROJECT_LOG.md tras cada modificación
- Tipos de entrada: FEATURE | BUG | DECISION

### UI Adaptativa
- **Nunca** usar el mismo widget para ambas plataformas
- Detectar plataforma: `Platform.isIOS`
- Material para Android, Cupertino para iOS

### Calidad
- 0 errores en `flutter analyze` antes de commit
- Usar `const` siempre que sea posible
- No hardcodear colores → usar ThemeData

---

## Workflow de Proyecto

1. **SPEC Update:** Actualizar `doc/<feature>/SPEC.md`
2. **Code:** Implementar código
3. **Gen:** Ejecutar `flutter pub get` y generadores
4. **Analyze:** `flutter analyze` (0 errores)
5. **Test:** Ejecutar tests
6. **Memory Log:** Registrar en `PROJECT_LOG.md`

---

## Estructura de Proyecto

```
lib/
├── core/
│   ├── error/         # Failures y excepciones
│   ├── network/       # Dio e interceptores
│   ├── di/           # GetIt
│   └── usecases/      # UseCase base
├── features/
│   └── [feature]/
│       ├── data/     # Models, Repositories, DataSources
│       ├── domain/   # Entities, UseCases, Repository contracts
│       └── presentation/  # Cubits, Pages, Widgets
└── main.dart
```

---

## Skills Relacionados

Si solo necesitas uno:

- `flutter-expert`: Solo arquitectura y lógica
- `ui-expert`: Solo diseño UI

---

## Repositorio

https://github.com/IvanMartinezLeon/FlutterCPAC