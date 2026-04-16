# Arquitectura CPAC

## Overview

FlutterCPAC implementa **Clean Architecture** con las siguientes características:

- Separación estricta en capas
- Features como módulos independientes
- Gestión de estado con **Bloc/Cubit**
- Inyección de dependencias via **GetIt**

---

## Estructura de Capas

```
lib/
├── core/                    # Compartido por todas las features
│   ├── error/               # Failures y excepciones
│   ├── network/             # Dio + interceptores
│   ├── di/                  # GetIt
│   └── usecases/            # UseCase base
├── features/                 # Módulos aislados
│   └── [feature_name]/
│       ├── data/
│       │   ├── datasources/ # Remote/Local
│       │   ├── models/      # DTOs
│       │   └── repositories/ # Impl
│       ├── domain/
│       │   ├── entities/    # Modelos de negocio
│       │   ├── repositories/ # Contratos abstractos
│       │   └── usecases/    # Lógica de negocio
│       └── presentation/
│           ├── bloc/        # BLoCs/Cubits
│           ├── pages/       # Screens
│           └── widgets/     # Componentes UI
└── main.dart
```

---

## Reglas de Arquitectura

### ✅ Permitido

```dart
// presentation → domain (vía cubit)
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  Future<void> login(String email) async {
    final result = await _loginUseCase(email);
    // ...
  }
}
```

### ❌ Prohibido

```dart
// ❌ presentation → data directamente
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = Dio(); // PROHIBIDO
    // ...
  }
}

// ❌ feature_A → feature_B
import 'package:app/features/auth/data/models/user_model.dart'; // PROHIBIDO
```

---

## Contrato de Eliminabilidad

Cada feature debe poder borrarse sin romper otras:

```
features/
├── auth/          # ← Puedo borrar esto
├── home/          # ← Funciona sin auth
└── settings/      # ← Funciona sin auth ni home
```

---

## State Management: Cubit/Bloc

```dart
// Estado simple
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}

// Estado complejo
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}
```

---

## Siguiente

- [Commands](Commands) → Comandos disponibles
- [QA Checklist](QA-Checklist) → Reglas de calidad
