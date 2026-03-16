# Reglas de Rendimiento

**Objetivo: 60 FPS en dispositivos de gama media. Perfilar con Flutter DevTools antes y después de cada optimización.**

---

## Reglas Principales

| Regla | Implementación |
|-------|----------------|
| Constructores const | Añadir `const` a cada widget estático |
| Evitar rebuilds | Usar `context.select()` para observar solo campos necesarios |
| Rendimiento de listas | `ListView.builder` + `itemExtent` cuando los items tienen altura uniforme |
| Imágenes | `cached_network_image` + redimensionar en origen |
| Trabajo pesado | Delegar con `compute()` o `Isolate.run()` — nunca bloquear hilo de UI |
| Caché de rasterizado | Añadir `RepaintBoundary` alrededor de subárboles animados complejos |

---

## Profiling

```bash
# Ejecutar en modo profile
flutter run --profile

# Usar Flutter DevTools para:
# - Timeline view (jank detection)
# - Memory profiling
# - Widget rebuild counts
```

---

## Green Software / Eficiencia

### Eficiencia Energética
- Usar `const` para evitar reconstrucciones innecesarias
- `RepaintBoundary` para aislar partes complejas de la UI
- Evitar animaciones infinitas en segundo plano
- Delegar trabajo pesado con `compute()` o `Isolate.run()`

### Eficiencia de Hardware
- Minimizar uso de CPU/GPU procesando datos localmente solo cuando sea necesario
- Reducir el tamaño del bundle para minimizar la energía de descarga

### Eficiencia de Datos
- Peticiones batch y caché agresiva para reducir tráfico de red
- Usar `ListView.builder` para virtualización de listas largas
