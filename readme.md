# Flutter_CPAC

**Flutter_CPAC** es un sistema automatizado para crear y configurar proyectos Flutter con estructura lista para producción. Utiliza un agente de IA que sigue un FlutterCPAC estandarizado para inicializar proyectos con configuración de múltiples entornos e internacionalización.

---

## Instalación

```bash
npx skills add https://github.com/IvanMartinezLeon/FlutterCPAC --skill flutter-cpac
```

Esto instala el repositorio completo (skills + scripts + templates).
|-------------|-----------|---------------|
| Global (`-g`) | `~/.agents/skills/` | Siempres usas las mismas reglas |
| Por proyecto | `./.agents/skills/` | Equipos con reglas diferentes por proyecto |

## 🚀 Crear un proyecto Flutter

```bash
# Instalar skill
npx skills add https://github.com/IvanMartinezLeon/FlutterCPAC --skill flutter-cpac
```

Luego, dile a la IA:

```
/crear-flutter
```

O simplemente pídele: "Crea un proyecto Flutter"

El script te guiará para configurar tu proyecto con:
- Multi-entorno (debug, profile, release)
- Internacionalización (ES/EN)
- Tu gestor de estado favorito

---

## Cómo decirle a la IA que cree un proyecto

Una vez instalado el skill, primero clona el repositorio y luego pídele a la IA:

```bash
git clone https://github.com/IvanMartinezLeon/FlutterCPAC.git mi_proyecto
cd mi_proyecto
```

Luego dile a la IA:

```
Ejecuta: bash scripts/init_project.sh

Datos del proyecto:
- Nombre: mi_app
- Bundle ID: com.miestudio.miapp
- Gestor de estado: Bloc/Cubit
```

La IA ejecutará el script y configurará el proyecto automáticamente.

**Repositorio:** https://github.com/IvanMartinezLeon/FlutterCPAC

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
git clone https://github.com/IvanMartinezLeon/FlutterCPAC.git

cd FlutterCPAC
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
4. El agente ejecutará el FlutterCPAC completo

El agente seguirá automáticamente el FlutterCPAC creando:
- Estructura de proyecto Flutter
- Tres archivos `.env` (debug, profile, release)
- Internacionalización (ES/EN)
- Documentación del proyecto
- PROJECT_LOG.md en la raíz

### Con agente de IA (recomendado)

Para que tu IA ejecute el script automáticamente, usa este prompt:

```
"Ejecuta el script init_project.sh desde este repositorio:
https://github.com/IvanMartinezLeon/FlutterCPAC

Usa estos datos cuando te pida:
- App: [tu_nombre_de_app]
- Bundle: [tu_bundle_id]
- State: 2 (Bloc/Cubit)"

Después verifica que flutter analyze no dé errores.
```

O的直接 Ejecutar:

```bash
git clone https://github.com/IvanMartinezLeon/FlutterCPAC.git && cd FlutterCPAC && bash init_project.sh
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
- Repositorio: https://github.com/IvanMartinezLeon/FlutterCPAC