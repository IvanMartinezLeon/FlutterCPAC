# Localización (L10n) y Entornos

---

## Localización con flutter_localizations + intl

### Configuración en pubspec.yaml

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0

flutter:
  generate: true
```

### l10n.yaml

```yaml
arb-dir: lib/l10n
template-arb-file: app_es.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
synthetic-package: false
output-dir: lib/l10n/generated
```

### Archivos ARB

```json
// lib/l10n/app_es.arb
{
  "@@locale": "es",
  "welcomeMessage": "¡Bienvenido de nuevo, {name}!",
  "@welcomeMessage": { "placeholders": { "name": { "type": "String" } } },
  "signIn": "Iniciar Sesión"
}

// lib/l10n/app_en.arb
{
  "@@locale": "en",
  "welcomeMessage": "Welcome back, {name}!",
  "@welcomeMessage": { "placeholders": { "name": { "type": "String" } } },
  "signIn": "Sign In"
}
```

### Generar

```bash
flutter gen-l10n
```

Locales soportados: **ES · EN · CA** (extender según necesidad). Nunca usar cadenas de texto crudas en widgets.

---

## Entornos con flutter_dotenv

### Archivos .env

```
assets/env/
├── .env.debug       # Desarrollo
├── .env.profile     # Preproducción
├── .env.release     # Producción
└── .env.example     # Referencia
```

### Contenido de .env

```bash
# .env.debug
ENVIRONMENT=debug
API_URL=https://api-dev.example.com
LOG_LEVEL=debug
FEATURE_FLAGS=true
APP_NAME="MiApp (DEV)"

# .env.profile
ENVIRONMENT=profile
API_URL=https://api-staging.example.com
LOG_LEVEL=info

# .env.release
ENVIRONMENT=release
API_URL=https://api.example.com
LOG_LEVEL=error
FEATURE_FLAGS=false
```

### Configurar en pubspec.yaml

```yaml
flutter:
  assets:
    - assets/env/.env.debug
    - assets/env/.env.profile
    - assets/env/.env.release
```

### Uso en código

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  const env = String.fromEnvironment('ENVIRONMENT', defaultValue: 'debug');
  await dotenv.load(fileName: 'assets/env/.env.$env');
  runApp(const MyApp());
}

// Acceso a variables
final apiUrl = dotenv.env['API_URL'] ?? '';
```

---

## Reglas
- Nunca cadenas de texto crudas en widgets → usar `AppLocalizations`
- Siempre tener archivos ARB para ES, EN (mínimo)
- Cada entorno tiene su propio `.env`
- No commitear `.env.release` con secretos reales → usar `.env.example`
