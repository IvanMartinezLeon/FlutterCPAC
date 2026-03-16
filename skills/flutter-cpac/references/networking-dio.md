# Capa de Red (Dio)

Configurar siempre interceptores. En modo **debug**, registrar detalles completos de solicitud/respuesta.

---

## Configuración Base

```dart
final dio = Dio(BaseOptions(
  baseUrl: EnvironmentConfig.apiUrl,
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
));
```

---

## Interceptores en Debug

```dart
if (kDebugMode) {
  dio.interceptors.add(LogInterceptor(
    requestBody: true,   // método, URL, parámetros query, cuerpo
    responseBody: true,  // código de estado, cuerpo de respuesta
    error: true,
  ));
}
```

El log debe mostrar: **Método · URL completa · Parámetros Query · Cuerpo de Solicitud · Estado HTTP · Cuerpo de Error**.

---

## Interceptor de Autenticación (ejemplo)

```dart
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenStorage.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Handle token refresh
    }
    handler.next(err);
  }
}
```

---

## Reglas

- Toda comunicación HTTP via Dio (no `http` package)
- Interceptores siempre configurados
- Logging solo en modo debug (`kDebugMode`)
- Errores de red capturados en `RepositoryImpl` → mapear a `Failure`
