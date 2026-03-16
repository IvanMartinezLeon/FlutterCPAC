# Contrato de Arquitectura CPAC (Cross-Platform Architecture Contract)

**Versión actual: 1.1.0**

La arquitectura se trata como un **contrato** entre desarrolladores, maintainers, QA y equipos futuros.

---

## Principio Central

Los límites arquitectónicos deben ser:
- **explícitos**
- **estables**
- **aplicables mediante tooling**

Cualquier cambio que debilite el aislamiento modular o introduzca acoplamiento oculto se considera **breaking change**.

---

## Alcance Protegido

El contrato protege y versiona:
- Límites de features/módulos
- APIs públicas de features
- Dirección de dependencias
- Ownership del código compartido
- Responsabilidades del composition root

---

## Modularización Orientada a Features

- La unidad estructural principal es la **feature**, no la capa técnica.
- Una feature representa una capacidad de negocio coherente.
- Las features deben poder eliminarse de forma independiente.

### Límites de Módulos

- Cada feature vive en su propio módulo bajo `features/`.
- Cada feature expone exactamente **un punto de entrada público**.
- Todo lo demás es implementación interna.
- Los archivos internos **no pueden importarse** desde fuera de la feature.

---

## Reglas de Dependencias entre Features

Por defecto, las dependencias entre features están **prohibidas**.

Si una dependencia es necesaria, debe ser:
- Explícitamente declarada
- Revisada
- Aplicable estáticamente
- Usar solo la API pública de la feature dependida
- Tener ownership documentado

Importaciones de conveniencia entre features están prohibidas.

---

## Composition Root

El wiring entre features solo ocurre en el **composition root** de la app:
- `lib/core/di/` - Inyección de dependencias
- `lib/main.dart` o configuración de router

Las features **no deben**:
- Instanciar otras features
- Navegar directamente a otras features
- Configurar otras features

El composition root puede depender de APIs públicas de features, nunca de internals.

---

## Estructura Interna de una Feature

Cada feature mantiene separación interna:
- **presentación** (UI, widgets, screens)
- **state management** (bloc, cubit, viewmodels)
- **dominio** (entidades, value objects, contratos)
- **data layer** (repositorios, APIs, persistencia)

Reglas:
- UI no depende directamente de data implementations
- Dominio no depende de data implementations
- Data puede depender de contratos de dominio

---

## Código Compartido (shared/common)

Permitido solo si es **realmente genérico**.

Reglas:
- No codificar semántica de negocio
- No convertirse en dumping ground
- Si varias features comparten semántica → crear nueva feature

> Componentes UI shared son bloques visuales genéricos sin lógica de negocio.

---

## Disciplina de API Pública

Las APIs públicas de feature deben ser:
- Mínimas
- Intencionales
- Estables

No exponer:
- Estado interno
- Modelos internos
- Tipos de implementación

Preferir exponer:
- Capacidades de feature
- Contratos de dominio

---

## Eliminabilidad (Definition of Done)

Una feature está correctamente modularizada solo si:
- Eliminarla solo requiere cambios en el wiring de app
- Ninguna otra feature rompe
- Fallos de build/test solo en registros explícitos

Si eliminar una feature requiere buscar referencias por todo el repo → contrato roto.

---

## Versionado del Contrato

**Versión actual: 1.1.0**

Cambios breaking requieren **major version bump**. Breaking incluye:
- Cambiar límites de features
- Cambiar dirección de dependencias
- Redefinir shared/common
- Cambiar semántica de APIs públicas

Cada cambio debe documentar:
- Alcance
- Motivo
- Migración
- Rollback

---

## Enforcement y Verificación

- Aplicar reglas mediante análisis estático siempre que sea posible.
- Review humano como capa secundaria.
- Rechazar cambios que introduzcan:
  - Acoplamiento oculto
  - Ownership difuso
  - Erosión de límites

La documentación debe reflejar la estructura real.
