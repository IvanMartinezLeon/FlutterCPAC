# Flutter_CPAC

**Flutter_CPAC** es un sistema automatizado para crear, configurar y auditar proyectos Flutter listos para la pre-producción. Utiliza contratos rígidos basados en Markdown para asegurar que cualquier agente de IA aplique Clean Architecture, inyecte Tokens de diseño estéticos y siga normativas de accesibilidad WCAG.

### 🤖 Agentes IA y Editores Soportados

Al ser un framework basado puramente en conocimiento Markdown y Scripts Bash, **es 100% universal**. Tienes soporte nativo garantizado en:
- **Agentes Nativos:** Antigravity, Claude Code, OpenCode.
- **IDEs con IA Integrada:** Cursor, Windsurf, Trae, Roo Code, GitHub Copilot.
- **Herramientas de Workflow:** CodeBuddy, Qoder, Gemini CLI.

---

## 📦 Instalación Global (En cualquier IA)

```bash
# Permite a tu Agente AI o IDE aprender sobre el contrato CPAC:
npx skills add IvanMartinezLeon/FlutterCPAC@flutter-cpac -g
```

| Tipo de instalación | Directorio destino | Caso de uso |
|-------------|-----------|---------------|
| Global (`-g`) | `~/.agents/skills/` | Quieres usar CPAC como tu estándar general en todos tus proyectos. |
| Por proyecto | `./.agents/skills/` | Reglas estrictas aplicadas al equipo de un único repositorio local. |

## 🚀 Crear un proyecto Flutter

## 🚀 Inicializar un Proyecto

Una vez tengas alojada la Skill (o simplemente abriendo la carpeta de este repositorio en el IDE), escribe a la IA en el chat:

> ```
> /crear-flutter
> ```

A continuación, la inteligencia empezará la cadena para inyectar un ecosistema con:
- Arquitectura Clean / BloC base automatizada.
- Internacionalización con `AppLocalizations` (ES/EN) + `DotEnv` multi-entorno.
- **¡NUEVO!** Preguntará por el "Sector de la app" (ej: *Banca, Retail, Clínicas...*) y formulará un `MASTER_THEME.md` generándote paletas y **Variables de UI** (Tokens) específicas para tu contexto.

---

## 🔎 Auditar un Proyecto Existente

Si aplicaste la arquitectura hace semanas y quieres pasar un control de calidad (o estás asumiendo código legado), pídele a la IA:

> ```
> /auditar-flutter
> ```

La inteligencia artificial auditará las carpetas escaneando el código en busca de: 
- Violaciones de arquitectura funcional (Ej: Dependencias cruzadas prohibidas).
- Vulneraciones estéticas (Ej: Colores o Sizes *hardcoded* en vez de usar los de `AppSpacing`).
- Peligros de Inaccesibilidad (Touch Targets diminutos o textos fijos en vez de flexibles).

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

- **Theming por Sector Propulsado por IA**: Inyección al crear el proyecto de un `MASTER_THEME.md` con UI tokens y paletas de color en función de la industria dada.
- **Regulaciones de Motion UI y Acceso**: Curvas de animación y tiempos bloqueados (normativa M3 UX Pro).
- **Tres entornos pre-configurados**: Debug, Profile y Release con archivos `.env` totalmente integrados en el código.
- **Memoria Continúa IA**: Generación intrínseca de `PROJECT_LOG.md` instando a la IA a memorizar sus "Variables UI" y decisiones en cada sesión para que otro agente pueda relevarlo al día siguiente sin perder contexto.
- **Clean Architecture Pura**: Estructura hermética de capas con separación de la presentación, dominio y datos.
- **Contrato CPAC**: Exigen que antes de cada commit obligatoriamente se pase un `flutter analyze`.

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

O ejecutar directamente desde una shell limpia en Bash:

```bash
git clone https://github.com/IvanMartinezLeon/FlutterCPAC.git && cd FlutterCPAC && bash scripts/init_project.sh
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