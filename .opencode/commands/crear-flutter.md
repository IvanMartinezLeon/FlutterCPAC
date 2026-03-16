---
description: Crear un proyecto Flutter con estructura CPAC lista para producción
agent: *
---

Crea un proyecto Flutter usando el workflow de FlutterCPAC.

1. Primero, ejecuta: `git clone https://github.com/IvanMartinezLeon/FlutterCPAC.git /tmp/FlutterCPAC && cd /tmp/FlutterCPAC`

2. Lee el archivo `skills/flutter-cpac/references/createproject.md` completo

3. Solicita al usuario los datos necesarios:
   - Nombre de la aplicación (ej: mi_app)
   - Bundle ID (ej: com.miestudio.miapp)
   - Gestor de estado (Riverpod, Bloc/Cubit, o Híbrido)

4. Ejecuta el workflow descrito en createproject.md:
   - Verificar entorno con flutter doctor
   - Crear proyecto con flutter create
   - Configurar multi-entorno (.env debug/profile/release)
   - Configurar internacionalización (ES/EN)
   - Crear estructura de directorios

5. Al finalizar, ejecuta `flutter analyze` y verifica que no haya errores

6. Muestra un resumen del proyecto creado