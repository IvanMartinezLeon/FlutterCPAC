# Arquitectura — <Nombre Feature>

## Patrón utilizado
Cubit (flutter_bloc) — Clean Architecture

## Capas
- **Presentation:** Widgets, Pages, Cubits
- **Domain:** Entities, UseCases, Repository contracts
- **Data:** Repositories, DataSources, Models/DTOs

## Modelos
- Entity: `<Nombre>Entity` (Dart puro)
- DTO: `<Nombre>Model` (json_serializable + freezed)
- Mapper: `toEntity()` / `fromEntity()`

## Dependencias
- GetIt para DI
- Either<Failure, T> desde repositories

## Notas
-
