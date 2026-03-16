# Gestión de Errores (Funcional — fpdart)

Los errores se capturan **solo** en `RepositoryImpl`, se mapean a objetos `Failure`, y se devuelven como `Either<Failure, T>`. La capa de UI nunca ve excepciones crudas.

---

## Tipos de Failure

```dart
// domain/entities/failure.dart
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
```

---

## Implementación en Repository

```dart
// data/repositories/auth_repository_impl.dart
@override
Future<Either<Failure, User>> signIn(String email, String password) async {
  try {
    final dto = await remoteDataSource.signIn(email, password);
    return Right(dto.toEntity());
  } on DioException catch (e) {
    return Left(NetworkFailure(ErrorMapper.fromDio(e)));
  } on CacheException catch (e) {
    return Left(CacheFailure(e.message));
  }
}
```

---

## Reglas

### ✅ Correcto
- `Either<Failure, T>` desde repositorios
- Capturar excepciones solo en la capa de datos
- Mapear excepciones a objetos `Failure` tipados
- UI consume vía `fold()` en el Cubit

### ❌ Incorrecto
- Lanzar excepciones desde repositorios hacia la UI
- Usar `try/catch` en Cubits/Blocs
- Usar `dynamic` como tipo de error
