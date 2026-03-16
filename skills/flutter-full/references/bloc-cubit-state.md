# Gestión de Estado con Cubit/Bloc

Usar **Cubit** (de `flutter_bloc`) para transiciones de estado sencillas. Usar **Bloc** para lógica de negocio compleja con eventos.

---

## Estado Sellado con Freezed

```dart
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial()                  = _Initial;
  const factory AuthState.loading()                  = _Loading;
  const factory AuthState.authenticated(User user)   = _Authenticated;
  const factory AuthState.unauthenticated()          = _Unauthenticated;
  const factory AuthState.failure(String message)    = _Failure;
}
```

---

## Cubit con Repositorio basado en Either

```dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.initial());

  final AuthRepository _authRepository;

  Future<void> signIn(String email, String password) async {
    emit(const AuthState.loading());
    final result = await _authRepository.signIn(email, password);
    result.fold(
      (failure) => emit(AuthState.failure(failure.message)),
      (user)    => emit(AuthState.authenticated(user)),
    );
  }
}
```

---

## Consumo en UI con BlocBuilder

```dart
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => switch (state) {
        _Loading()            => const CircularProgressIndicator(),
        _Authenticated(:final user) => HomeScreen(user: user),
        _Failure(:final message)    => ErrorView(message: message),
        _             => const LoginForm(),
      },
    );
  }
}
```

---

## Proveer vía BlocProvider

```dart
// Usar GetIt para inyección de repositorios
BlocProvider(
  create: (_) => GetIt.I<AuthCubit>(),
  child: const LoginPage(),
)
```

---

## Reglas

### ✅ MUST DO
- `BlocBuilder` / `BlocListener` / `BlocConsumer` para consumo de estado
- Usar **BlocListener** para efectos secundarios (navegación, snackbars)
- Nunca poner efectos secundarios dentro de `build()`
- Producir nuevas instancias de estado (`copyWith`) — nunca mutar directamente

### ❌ MUST NOT DO
- Usar `StatefulWidget` + `setState` para estado compartido
- Solo `setState` para estado efímero puramente local del widget (ej: tick de animación)
- Construir widgets helper dentro de `build()` — extraerlos como clases separadas

---

## Organización por Feature

- **NUNCA** crear Cubits/Blocs en `lib/` directamente
- Siempre dentro de la feature: `lib/features/<feature>/presentation/cubits/`

```
lib/features/<feature>/
├── presentation/
│   ├── cubits/
│   │   └── <nombre>_cubit.dart
│   │   └── <nombre>_state.dart
│   ├── pages/
│   └── widgets/
```
