# Navegación con GoRouter

Configurar rutas de navegación con GoRouter para navegación declarativa y gestión de estado de rutas.

---

## Configuración Básica

```dart
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final isLoggedIn = /* check auth */;
    if (!isLoggedIn && !state.matchedLocation.startsWith('/auth')) {
      return '/auth/login';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DetailsScreen(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

// En app.dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
```

---

## Métodos de Navegación

```dart
// Navegar y reemplazar historial
context.go('/details/123');

// Navegar y añadir a la pila
context.push('/details/123');

// Volver atrás
context.pop();

// Reemplazar ruta actual
context.pushReplacement('/home');

// Navegar con datos extra
context.push('/details/123', extra: {'title': 'Item'});

// Acceder a extra en destino
final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
```

---

## Shell Routes (UI Persistente)

```dart
final goRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ),
  ],
);
```

---

## Parámetros de Consulta

```dart
GoRoute(
  path: '/search',
  builder: (context, state) {
    final query = state.uri.queryParameters['q'] ?? '';
    final page = int.tryParse(state.uri.queryParameters['page'] ?? '1') ?? 1;
    return SearchScreen(query: query, page: page);
  },
),

// Navegar con query params
context.go('/search?q=flutter&page=2');
```

---

## Autenticación y Guards

```dart
redirect: (context, state) {
  final authState = context.read<AuthCubit>().state;
  if (authState is! Authenticated) {
    return '/auth/login';
  }
  return null;
}
```

---

## Referencia Rápida

| Método | Comportamiento |
|--------|-----------------|
| `context.go()` | Navegar, reemplazar pila |
| `context.push()` | Navegar, añadir a pila |
| `context.pop()` | Volver atrás |
| `context.pushReplacement()` | Reemplazar actual |
| `:param` | Parámetro de ruta |
| `?key=value` | Parámetro de consulta |