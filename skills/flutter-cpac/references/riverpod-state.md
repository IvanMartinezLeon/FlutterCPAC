# Gestión de Estado con Riverpod

Usar Riverpod para gestión de estado reactiva con tipado fuerte y soporte para código generación.

---

## Providers Básicos

```dart
// Provider simple
final messageProvider = Provider<String>((ref) => 'Hello World');

// Provider con dependencia
final repositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(dioProvider));
});

// StateProvider para estado simple
final counterProvider = StateProvider<int>((ref) => 0);
```

---

## StateNotifier

```dart
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);
```

---

## AsyncValue para Estados Asíncronos

```dart
final usersProvider = FutureProvider<List<User>>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUsers();
});

// En el widget
final asyncUsers = ref.watch(usersProvider);

asyncUsers.when(
  data: (users) => ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) => UserTile(user: users[index]),
  )),
  loading: () => const CircularProgressIndicator(),
  error: (error, stack) => Text('Error: $error'),
);
```

---

## Family Providers (con parámetros)

```dart
final userByIdProvider = FutureProvider.family<User, String>((ref, id) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUserById(id);
});

// Uso con parámetro
final user = ref.watch(userByIdProvider('123'));
```

---

## Notifier con código generación

```dart
part 'counter.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state--;
}

// Uso
final counter = ref.watch(counterProvider);
ref.read(counterProvider.notifier).increment();
```

---

## Provider para Diferentes Tipos de Estado

| Tipo | Provider | Uso |
|------|----------|-----|
| Solo lectura | `Provider` | Constantes, dependencias |
| Estado simple | `StateProvider` | Contadores, flags |
| Estado complejo | `StateNotifierProvider` | Listas, objetos |
| Async | `FutureProvider` | Datos remotos |
| Async con params | `FutureProvider.family` | Por ID |
| Stream | `StreamProvider` | Sockets, suscripciones |

---

## go_router con Riverpod

```dart
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = ref.read(authProvider);
      if (!isLoggedIn && state.matchedLocation != '/login') {
        return '/login';
      }
      return null;
    },
  );
});
```

---

## Dependency Injection con Riverpod

```dart
final dioProvider = Provider<Dio>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  return Dio(BaseOptions(baseUrl: baseUrl));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(dioProvider));
});

final userProvider = FutureProvider<User>((ref) async {
  return ref.watch(userRepositoryProvider).getCurrentUser();
});
```

---

## Mejores Prácticas

✅ Usar `ref.watch` para reactivity
✅ Usar `ref.read` solo en callbacks (onPressed, etc)
✅ Crear providers para cada dependencia
✅ Usar `family` para providers con parámetros
✅ Manejar estados de carga y error con `AsyncValue`

❌ No usar providers en `build()` directamente sin watch
❌ No crear providers dentro de widgets