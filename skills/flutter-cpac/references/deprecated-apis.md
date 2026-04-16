# Deprecated APIs List

> Lista de APIs deprecated o deprecadas que NO deben usarse en proyectos CPAC.

---

## Dart/Flutter Core

### ❌ NO USAR

| API | Deprecated | Alternativa | Notes |
|-----|------------|-------------|-------|
| `Timer.periodic` | Dart 3.0+ | `Stream.periodic` | Para timers periódicos |
| `Timer.run` | Dart 3.0+ | `Future.delayed` | Para ejecución async |
| `DateTime.now().toLocal()` | Dart 3.0+ | Sin替代 (usar direktamente) | Timezone handling |
| `StackTrace.current` | Dart 3.0+ | `FlutterError.presentStackTrace` | En Flutter |
| `WidgetsBinding.instance` | Flutter 3.16+ | `WidgetsBinding.instance` (singelton) | Solo uso direto |

### ⚠️ CUIDADO

| API | Warning | Alternativa |
|-----|---------|-------------|
| `Stream.any` | Renombrado | `Stream.any((e) => e)` |
| `Iterable.any` | Renombrado | `Iterable.any((e) => e)` |

---

## Packages - Deprecated

### flutter_bloc

| API | Deprecated | Alternativa |
|-----|------------|-------------|
| `Cubit.stream` | v8.0+ | No escuchar stream diretamente |
| `Bloc.transformEvents` | v8.0+ | Usar `EventTransformer` |
| `EventTransformer` | v8.0+ | `EventTransformer` es abstract now |

### get_it

| API | Deprecated | Alternativa |
|-----|------------|-------------|
| `registerFactory<Func>` | v7.0+ | `registerFactory<F>` |
| `registerSingleton<F>` | v7.0+ | `registerSingleton<F>(factory: () => F())` |

### dio

| API | Deprecated | Alternativa |
|-----|------------|-------------|
| `Options.method` | v5.0+ | Usar directamente `method` parameter |
| `Response.data` | v5.0+ | `Response.data` → `data` directamente |

### go_router

| API | Deprecated | Alternativa |
|-----|------------|-------------|
| `ShellRoute.builder` | v14.0+ | `ShellRoute.builder` → usar `builder` parameter |
| `GoRouter.routeInformationParser` | v14.0+ | Usar `RouteInformationParser` con tipo genérico |

### freezed

| API | Deprecated | Alternativa |
|-----|------------|-------------|
| `@freezed` sin `with` | v3.0+ | Usar `with JsonSerializable` |
| `copyWith` con null params | v3.0+ | Usar `copyWith.missing()` |

### json_serializable

| API | Deprecated | Alternativa |
|-----|------------|-------------|
| `JsonKey.defaultValue` con complex | v6.0+ | Factory constructor |
| `Boolean.defaultValue` | v6.0+ | Usar `bool defaultValue` |

---

## Flutter Widgets - Deprecated

| Widget | Deprecated | Alternativa | Notes |
|--------|------------|-------------|-------|
| `ElevatedButton.icon` | Flutter 3.x | `FilledButton.icon` | M3 guidelines |
| `TextButton.icon` | Flutter 3.x | `TonalButton.icon` | M3 guidelines |
| `OutlinedButton.icon` | Flutter 3.x | `OutlinedButton.icon` (same) | M3 guidelines |
| `CircularProgressIndicator.adaptive` | Flutter 3.16+ | `CupertinoActivityIndicator` | Platform-specific |
| `ListTileTheme` | Flutter 3.x | `ListTileThemeData` | Refactor |

---

## UI Patterns - NO RECOMENDADOS

### ❌ Spacing Hardcoded

```dart
// ❌ NO USAR
EdgeInsets.all(12)
EdgeInsets.only(left: 20, top: 16)
SizedBox(height: 20)
Padding(padding: EdgeInsets.all(8))

// ✅ USAR
EdgeInsets.all(AppSpacing.md)  // 16
EdgeInsets.only(left: AppSpacing.lg, top: AppSpacing.md)
SizedBox(height: AppSpacing.lg)
Padding(padding: EdgeInsets.all(AppSpacing.sm))
```

### ❌ Colores Hardcoded

```dart
// ❌ NO USAR
Color(0xFF2196F3)
Colors.red
Container(color: Colors.blue)

// ✅ USAR
Theme.of(context).colorScheme.primary
AppColors.primary
```

### ❌ Durations Hardcoded

```dart
// ❌ NO USAR
Duration(milliseconds: 300)
Duration(seconds: 1)

// ✅ USAR
AppMotion.medium
Duration(milliseconds: AppMotionDurations.medium)
```

### ❌ TextScaler

```dart
// ❌ NO USAR - Elimina accesibilidad
TextScaler.noScaling
MediaQuery.textScalerOf(context).deactivate()

// ✅ USAR - Respetar configuración del usuario
DefaultTextStyle(
  style: TextStyle(fontSize: 16),
  child: Text('texto'),
)
```

### ❌ Touch Targets

```dart
// ❌ NO USAR - Menos de 48px
IconButton(iconSize: 24, ...)
GestureDetector(child: SizedBox(width: 20, height: 20, ...))

// ✅ USAR - Mínimo 48px
IconButton(iconSize: 24, constraints: BoxConstraints(minWidth: 48, minHeight: 48), ...)
GestureDetector(child: SizedBox(width: 48, height: 48, ...))
```

---

## State Management - NO RECOMENDADOS

### ❌ setState Global

```dart
// ❌ NO USAR
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _count = 0;

  void _increment() => setState(() => _count++); // Solo para estado LOCAL
}

// ✅ USAR - Para estado de negocio
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}
```

### ❌ BLoC sin BlocObserver

```dart
// ❌ SIN logging
void main() {
  runApp(MyApp());
}

// ✅ CON logging para desarrollo
class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType}: $change');
  }
}

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
```

---

## Architecture - NO PERMITIDOS

### ❌ Dependencias Cruzadas entre Features

```dart
// ❌ NO USAR - Feature A importando de Feature B
import 'package:app/features/auth/data/models/user_model.dart'; // de auth
import 'package:app/features/home/presentation/pages/home_page.dart'; // de home

// ✅ USAR - Communication via core o events
import 'package:app/core/events/user_logged_in_event.dart';
```

### ❌ Widgets Instanciando Dio/Repositories

```dart
// ❌ NO USAR
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = Dio(); // ❌ WRONG
    final repo = UserRepository(dio); // ❌ WRONG

    return ElevatedButton(
      onPressed: () => repo.getUser(),
      child: Text('Get User'),
    );
  }
}

// ✅ USAR - DI via GetIt o contexto
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repo = context.read<UserRepository>(); // ✅ CORRECTO

    return ElevatedButton(
      onPressed: () => repo.getUser(),
      child: Text('Get User'),
    );
  }
}
```

---

## Testing - NO RECOMENDADOS

### ❌ Tests sin Coverage

```dart
// ❌ NO USAR
test('my test', () {
  expect(1 + 1, 2);
}); // Sin cubit test coverage

// ✅ USAR - Testear cubits
blocTest<CounterCubit, int>(
  'emits [2] when increment is called',
  build: () => CounterCubit(),
  act: (cubit) => cubit.increment(),
  expect: () => [2],
);
```

### ❌ Mocks sin when

```dart
// ❌ NO USAR
when(repository.getUser()).thenAnswer((_) async => User());
// Falta verificar
verify(repository.getUser()).called(1);

// ✅ USAR - Completo
when(repository.getUser()).thenAnswer((_) async => User());

await cubit.fetchUser();

verify(repository.getUser()).called(1);
```

---

## Importancia de Seguir Esta Lista

Usar APIs deprecated puede causar:

1. **Breaking Changes** — Fallos en próximas versiones de Flutter/Dart
2. **Errores de Linting** — Warnings en `flutter analyze`
3. **Deuda Técnica** — Refactorizaciones futuras necesarias
4. **Incompatibilidad** — Con versiones de packages

---

## Actualizaciones

Esta lista se actualiza cuando:
- Nueva versión de Flutter/Dart es released
- Nuevo package version con breaking changes
- Nuevo pattern anti-recomendado es detectado

Última actualización: YYYY-MM-DD
