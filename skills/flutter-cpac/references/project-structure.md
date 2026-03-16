# Estructura de Proyecto Flutter (CPAC)

Cada feature vive en su propio módulo bajo `features/` para asegurar escalabilidad y separación de preocupaciones.

---

## Estructura de Carpetas

```plaintext
lib/
├── core/
│   ├── error/             # Fallos globales y excepciones
│   ├── network/           # Configuración de Dio e interceptores
│   ├── di/                # Inyección de dependencias (GetIt + injectable)
│   ├── router/            # Configuración de GoRouter y definiciones de rutas
│   └── usecases/          # Clase base abstracta UseCase<Type, Params>
├── features/
│   └── [nombre_feature]/
│       ├── data/
│       │   ├── datasources/   # Remoto (Dio) y Local (Hive/SharedPrefs)
│       │   ├── models/        # DTOs serializables JSON (json_serializable)
│       │   └── repositories/  # RepositoryImpl — captura excepciones, devuelve Either
│       ├── domain/
│       │   ├── entities/      # Clases Dart puras, sin dependencias de frameworks
│       │   ├── repositories/  # Contratos abstractos
│       │   └── usecases/      # Lógica de negocio de responsabilidad única
│       └── presentation/
│           ├── cubits/        # Clases Cubit + State por feature
│           ├── pages/         # Widgets de pantalla de nivel superior
│           └── widgets/       # Componentes de UI atómicos y reutilizables
└── main.dart              # Configuración de BlocObserver + arranque de app
```

---

## Organización de Archivos por Feature

### Reglas Generales
- **NUNCA** crear en `lib/` directamente
- Siempre crear dentro de la estructura de su feature: `lib/features/<nombre-feature>/<tipo>/`

### Ejemplos por Tipo
| Tipo | Ubicación |
|------|-----------|
| Cubit | `lib/features/<feature>/presentation/cubits/<nombre_cubit>/` |
| BLoC | `lib/features/<feature>/presentation/blocs/<nombre_bloc>/` |
| Repository | `lib/features/<feature>/data/repositories/` |
| Model/DTO | `lib/features/<feature>/data/models/` |
| Entity | `lib/features/<feature>/domain/entities/` |
| UseCase | `lib/features/<feature>/domain/usecases/` |
| Screen/Page | `lib/features/<feature>/presentation/pages/` |
| Widget | `lib/features/<feature>/presentation/widgets/` |

### Si no existe la carpeta de la feature:
1. Primero crear la documentación en `doc/<nombre-feature>/`
2. Crear la estructura de carpetas en `lib/features/<nombre-feature>/`
3. Luego crear el Cubit/BLoC/etc. dentro de esa estructura

---

## Convenciones de Naming

| Tipo | Convención |
|------|------------|
| Clases | PascalCase |
| Variables/funciones | camelCase |
| Archivos | snake_case |

### Convenciones DB: Drift + Supabase

**Drift (Dart):** camelCase
```dart
TextColumn get modelName => text().nullable()();
```

**PostgreSQL/Supabase:** snake_case
```sql
CREATE TABLE equipment_items (model_name text);
```

**Entidades de dominio:** usar `@JsonKey`
```dart
class EquipmentItem {
  @JsonKey(name: 'model_name')
  final String? modelName;
}
```

---

## Convenciones de Código

- **Idioma**: Todo el código en **inglés**. Texto de UI localizado (ES/EN/CA).
- **Tipado**: `dynamic` está **prohibido** — mapear todas las respuestas a modelos tipados.
- **Serialización**: Usar `json_serializable` + `freezed` para modelos inmutables.
- **Keys**: Siempre proveer keys en listas y widgets reordenados dinámicamente.
