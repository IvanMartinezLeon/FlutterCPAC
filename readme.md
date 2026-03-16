# Flutter_CPAC

**Flutter_CPAC** es un sistema automatizado para crear y configurar proyectos Flutter con estructura lista para producción. Utiliza un agente de IA que sigue un workflow estandarizado para inicializar proyectos con configuración de múltiples entornos e internacionalización.

---

## Instalación como Skill (skills.sh)

```bash
# OPCIÓN 1: Skill completo (recomendado) - arquitectura + UI
npx skills add IvanMartinezLeon/workflow@flutter-full

# OPCIÓN 2: Skills individuales
npx skills add IvanMartinezLeon/workflow@flutter-expert
npx skills add IvanMartinezLeon/workflow@ui-expert
```

O manualmente:

```bash
# Crear directorio de skills
mkdir -p ~/.agents/skills

# Skill completo (arquitectura + UI)
curl -o ~/.agents/skills/flutter-full/SKILL.md https://raw.githubusercontent.com/IvanMartinezLeon/workflow/main/skills/flutter-full.md

# O individualmente
curl -o ~/.agents/skills/flutter-expert/SKILL.md https://raw.githubusercontent.com/IvanMartinezLeon/workflow/main/skills/flutter-expert.md
curl -o ~/.agents/skills/ui-expert/SKILL.md https://raw.githubusercontent.com/IvanMartinezLeon/workflow/main/skills/ui-expert.md
```

**Skills disponibles:**
- `flutter-full` ⭐ - Completo (arquitectura CPAC + UI adaptativa)
- `flutter-expert` - Solo arquitectura y lógica
- `ui-expert` - Solo diseño UI (Material/Cupertino)

### Global vs Por Proyecto

```bash
# GLOBAL (recomendado): Disponible para todos los proyectos
npx skills add IvanMartinezLeon/workflow@flutter-full -g

# POR PROYECTO: Solo ese proyecto tendrá el skill
cd mi_proyecto
npx skills add IvanMartinezLeon/workflow@flutter-full
```

| Instalación | Ubicación | Cuándo usarlo |
|-------------|-----------|---------------|
| Global (`-g`) | `~/.agents/skills/` | Siempres usas las mismas reglas |
| Por proyecto | `./.agents/skills/` | Equipos con reglas diferentes por proyecto |

**Repositorio:** https://github.com/IvanMartinezLeon/workflow

---

## Características

- **Tres entornos configurados**: Debug, Profile y Release con archivos `.env` separados
- **Internacionalización integrada**: Español (castellano) e Inglés con detección automática del idioma del dispositivo
- **Gestores de estado soportados**: Riverpod, Bloc/Cubit e Híbrido
- **Documentación automática**: Plantillas para especificaciones, arquitectura y decisiones
- **Reglas de calidad**: Análisis de código y formateo obligatorio
- **Clean Architecture**: Estructura de capas con separación de concerns (data/domain/presentation)
- **Gestión de estado con Cubit**: Estados tipados con freezed y manejo de errores con Either
- **UI Adaptativa**: Material Design 3 (Android) y Cupertino (iOS)
- **Contrato CPAC**: Arquitectura versionada y modular con features aisladas

---

## Uso

### Con script automático

```bash
# Clonar el repositorio
git clone https://github.com/IvanMartinezLeon/workflow.git

cd workflow
```

El script tiene **dos modos**:

```bash
# MODO SIMPLE: Solo crea estructura (sin IA)
bash scripts/init_project.sh --simple

# MODO CON IA: Crea proyecto + guía para configurar con IA
bash scripts/init_project.sh --with-ai

# MODO INTERACTIVO: Pregunta qué hacer (default)
bash scripts/init_project.sh
```

El script automáticamente:
1. Crea el proyecto Flutter
2. Configura los tres entornos (.env)
3. Configura i18n (ES/EN)
4. Crea PROJECT_LOG.md
5. Instala dependencias
6. Ejecuta `flutter analyze`

### Con agente de IA (manual)

1. Descarga el repositorio
2. Abre `createproject.md` con tu agente de IA
3. Proporciona los datos del proyecto
4. El agente ejecutará el workflow completo

El agente seguirá automáticamente el workflow creando:
- Estructura de proyecto Flutter
- Tres archivos `.env` (debug, profile, release)
- Internacionalización (ES/EN)
- Documentación del proyecto
- PROJECT_LOG.md en la raíz

### Con agente de IA (recomendado)

Para que tu IA ejecute el script automáticamente, usa este prompt:

```
"Ejecuta el script init_project.sh desde este repositorio:
https://github.com/IvanMartinezLeon/workflow

Usa estos datos cuando te pida:
- App: [tu_nombre_de_app]
- Bundle: [tu_bundle_id]
- State: 2 (Bloc/Cubit)"

Después verifica que flutter analyze no dé errores.
```

O的直接 Ejecutar:

```bash
git clone https://github.com/IvanMartinezLeon/workflow.git && cd workflow && bash init_project.sh
```

### 4. Comandos útiles del proyecto generado

```bash
# Verificar entorno
flutter doctor

# Instalar dependencias
flutter pub get

# Generar localizaciones
flutter gen-l10n

# Análisis de código (obligatorio antes de commit)
flutter analyze

# Formatear código
dart format .

# Ejecutar tests con cobertura
flutter test --coverage
```

---

## Estructura del Proyecto

El proyecto sigue una arquitectura limpia con separación de características:

```
lib/
├── core/                      # Configuraciones globales
│   ├── error/                 # Fallos globales y excepciones
│   ├── network/               # Configuración de Dio e interceptores
│   ├── di/                    # Inyección de dependencias (GetIt)
│   └── usecases/              # Clase base abstracta UseCase
├── features/                  # Módulos por funcionalidad
│   └── [feature]/
│       ├── data/              # Fuentes de datos y modelos
│       ├── domain/            # Entidades y lógica de negocio
│       └── presentation/      # UI y estado (Cubits, Pages, Widgets)
└── main.dart                  # Configuración y arranque
```

---

## Documentos del Proyecto

| Archivo | Propósito |
|---------|-----------|
| `PROJECT_LOG.md` | Decisiones, errores y aprendizajes unificados (raíz) |
| `doc/<feature>/SPEC.md` | Especificación de feature |
| `doc/<feature>/TODO.md` | Checklist de feature |

---

## Reglas de Calidad (Contrato CPAC)

Antes de cada commit, ejecuta:

```bash
flutter analyze && dart format .
```

**Nunca repetir un error ya documentado en PROJECT_LOG.md**

---

## Skills del Agente

| Skill | Descripción |
|-------|-------------|
| `flutter_expert` | Arquitectura CPAC, Clean Architecture, SDD, documentación automática |
| `ui_expert` | Material Design 3, Cupertino, widgets adaptativos |

---

## Más Información

- Documentación completa: [createproject.md](./createproject.md)
- Repositorio: https://github.com/IvanMartinezLeon/workflow