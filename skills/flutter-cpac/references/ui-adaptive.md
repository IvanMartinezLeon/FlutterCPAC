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

## Spacing System (Unificado)

```dart
abstract class AppSpacing {
  static const double xs  =  4.0;
  static const double sm  =  8.0;
  static const double md  = 16.0;
  static const double lg  = 24.0;
  static const double xl  = 32.0;
  static const double xxl = 48.0;
}
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

## Accesibilidad

- **Android:** 48dp mínimo touch target
- **iOS:** 44x44pt mínimo touch target
- Siempre usar `Semantics` para describir widgets interactivos

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
