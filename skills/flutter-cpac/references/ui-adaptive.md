# UI Adaptativa: Material Design 3 + Cupertino

**Regla de Oro:** Nunca usar el mismo widget para ambas plataformas. Siempre detectar la plataforma y renderizar el widget nativo correspondiente.

---

## Detección de Plataforma

```dart
import 'dart:io' show Platform;

Widget build(BuildContext context) {
  return Platform.isIOS
    ? CupertinoButton(...)
    : ElevatedButton(...);
}
```

---

## Material Design 3 (Android)

### Tokens de Diseño
- Colores: `ColorScheme.fromSeed()` (Dynamic Colors)
- Tipografía: `TextTheme` con escala type scale
- Espaciado: múltiplos de 4dp
- Shapes: `BorderRadius` según tipo de componente
- Elevación: sombras adaptadas a Material 3

### Componentes Principales

| Componente | Widget | Uso |
|------------|--------|-----|
| Pantalla | `Scaffold` | Estructura base |
| AppBar | `AppBar` | Barra superior |
| Navegación inferior | `NavigationBar` | Navegación principal |
| Botón primario | `FilledButton` | Acción principal |
| Botón secundario | `OutlinedButton` | Acción secundaria |
| Campo de texto | `TextField` | Entrada de texto |
| Tarjeta | `Card` | Contenedor |
| Dialog | `AlertDialog` | Confirmaciones |
| FAB | `FloatingActionButton` | Acción rápida |

### ThemeData

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 57),
    headlineLarge: TextStyle(fontSize: 32),
    titleLarge: TextStyle(fontSize: 22),
    bodyLarge: TextStyle(fontSize: 16),
    labelLarge: TextStyle(fontSize: 14),
  ),
)
```

---

## Cupertino Design (iOS)

### Tokens
- **SF Symbols:** Iconos de sistema iOS
- **Tipografía:** SF Pro (via `CupertinoTextThemeData`)
- **Espaciado:** Múltiplos de 8pt (iOS HIG)
- **Transiciones:** Cupertino page transitions

### Componentes Principales

| Componente | Widget | Uso |
|------------|--------|-----|
| Pantalla | `CupertinoPageScaffold` | Estructura base |
| NavigationBar | `CupertinoNavigationBar` | Barra de navegación |
| TabBar | `CupertinoTabScaffold` | Navegación por tabs |
| Botón | `CupertinoButton` | Acción |
| Campo de texto | `CupertinoTextField` | Entrada de texto |
| Alert | `CupertinoAlertDialog` | Confirmaciones |

### CupertinoThemeData

```dart
CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: CupertinoColors.activeBlue,
  scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
)
```

---

## Componentes Adaptativos

### Botones

```dart
Widget adaptiveButton({
  required String label,
  required VoidCallback onPressed,
  bool isPrimary = true,
}) {
  if (Platform.isIOS) {
    return CupertinoButton(onPressed: onPressed, child: Text(label));
  }
  return isPrimary
    ? FilledButton(onPressed: onPressed, child: Text(label))
    : OutlinedButton(onPressed: onPressed, child: Text(label));
}
```

### TextFields, Dialogs, Loading

Aplicar mismo patrón: detectar plataforma → widget nativo.

---

## Tokens UI y Sistema de Escalado (UI UX Pro)

La aplicación **debe** basar todo su diseño visual en constantes estáticas en \`lib/config/app_theme_tokens.dart\`. Queda terminantemente prohibido usar tamaños calculados al vuelo (ej: \`width: 20\`) o tipografías fuera de escala.

### 1. Spacing System (Múltiplos Cuadráticos de Oro M3)

Usar siempre estos múltiplos y nunca crear espaciados intermedios (ej: 10, 12).

```dart
abstract class AppSpacing {
  static const double xs  =  4.0;
  static const double sm  =  8.0;
  static const double md  = 16.0;  /// Padding base ideal M3
  static const double lg  = 24.0;  /// Separaciones entre tarjetas
  static const double xl  = 32.0;
  static const double xxl = 48.0;  /// Tamaño mínimo de Touch Target
}
```

### 2. Motion y Animaciones Estrictas

La UX determina que el ojo humano se fatiga con animaciones inconexas. Las interacciones en base al contrato requerirán:

```dart
abstract class AppMotion {
  static const Duration fast   = Duration(milliseconds: 150); /// Hovers, Ripples, Switches
  static const Duration normal = Duration(milliseconds: 250); /// Layout shifts, Dialog transitions
  static const Duration slow   = Duration(milliseconds: 350); /// Push/Pop Pages, Modals pesados
  
  static const Curve defaultCurve = Curves.easeInOutCubic;
}
```
*Prohibido:* Hardcodear \`Duration(seconds: 1)\` o duraciones ajenas a \`AppMotion\`.

### 3. Tipografía Universal (Google Fonts)

Si el `MASTER_THEME.md` define una fuente especial (ej: *Inter* o *Cormorant*), se inyectará en todo el `MaterialApp` utilizando la librería de `google_fonts`:

```dart
// ThemeData(
//   textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
// )
```

---

## Responsive Breakpoints

| Dispositivo | Ancho | Layout |
|-------------|-------|--------|
| Phone | < 600px | Single column |
| Tablet Portrait | 600-840px | Two column |
| Tablet Landscape | > 840px | Master-detail |
| Desktop | > 1200px | Full dashboard |

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) return phoneLayout();
    return tabletLayout();
  },
)
```

---

## Accesibilidad (WCAG 2.2 Compliance)

Para cumplir estrictamente con los estándares legales de accesibilidad AA/AAA:

**1. Target Size (WCAG 2.5.8):**
- **Android:** 48dp mínimo touch target
- **iOS:** 44x44pt mínimo touch target
- Espaciado: Nunca colocar dos botones juntos si su área clicable mide menos de 24x24 px.

**2. Contrastes Mínimos (WCAG 1.4.3 y 1.4.11):**
- **Textos normales:** Contraste mínimo de **4.5:1** respecto a su fondo.
- **Títulos y Componentes UI (Iconos, inputs):** Contraste mínimo de **3:1**.
- Evitar usar el color como única vía para denotar estado (ej. Errores deben llevar ícono además de texto rojo).

**3. Resize Text (WCAG 1.4.4):**
- Prohibido suprimir la accesibilidad del usuario: `TextScaler.noScaling` **nunca debe usarse**.
- Los layouts deben prever que el texto pueda escalar hasta el 200%. Evitar anchos o altos fijos (`height`, `width`) en contenedores de texto, usar padding en su lugar para evitar overflow.

**4. Foco Inteligente (WCAG 2.4.11):**
- Prevenir que el teclado oculte campos de texto: asegurar siempre `resizeToAvoidBottomInset: true` en los Scaffolds.

**5. Screen Readers:**
- Siempre envolver interfaces custom no descriptivas con `Semantics(label: '...', button: true)` para el TalkBack / VoiceOver.

---

## Reglas

### ✅ MUST DO
- Usar siempre ThemeData (nunca hardcodear colores, fonts, spacing)
- Detectar plataforma para widgets nativos
- Usar sistema de spacing (múltiplos de 4)
- `const` constructors siempre que sea posible

### ❌ MUST NOT DO
- Hardcodear colores: `Color(0xFF333333)` ← prohibido
- Hardcodear fuentes: `TextStyle(fontSize: 18)` ← prohibido
- Mismo widget para ambas plataformas
