# Testing en Flutter

Mínimo **80% de cobertura en tests de widgets**. La estructura de tests refleja `lib/`.

---

## Test de Widget con bloc_test

```dart
void main() {
  group('LoginPage', () {
    late MockAuthCubit mockAuthCubit;

    setUp(() => mockAuthCubit = MockAuthCubit());

    testWidgets('muestra mensaje de error en estado de fallo', (tester) async {
      whenListen(
        mockAuthCubit,
        Stream.fromIterable([
          const AuthState.loading(),
          const AuthState.failure('Credenciales inválidas'),
        ]),
        initialState: const AuthState.initial(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuthCubit,
          child: const MaterialApp(home: LoginPage()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Credenciales inválidas'), findsOneWidget);
    });
  });
}
```

---

## Comandos de Verificación

Ejecutar antes de cada commit:

```bash
flutter test --coverage
flutter analyze
dart format . --set-exit-if-changed
```

---

## Estructura de Tests

```
test/
├── features/
│   └── [feature]/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   └── usecases/
│       └── presentation/
│           ├── cubits/
│           └── widgets/
└── core/
```

---

## Reglas

- Tests unitarios para UseCases y Repositories
- Tests de widget para Pages y componentes clave
- Usar `mocktail` o `mockito` para mocks
- Usar `bloc_test` para testing de Cubits/Blocs
- `flutter analyze` debe dar 0 errores antes de PR
