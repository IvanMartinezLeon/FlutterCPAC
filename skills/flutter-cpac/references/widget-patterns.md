# Patrones de Widgets

Patrones avanzados de widgets para optimizar rendimiento y crear interfaces reutilizables.

---

## Patrón de Widget Optimizado

```dart
// Usar constructores const
class OptimizedCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const OptimizedCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}
```

---

## Layout Responsivo

```dart
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) return desktop;
        if (constraints.maxWidth >= 650) return tablet ?? mobile;
        return mobile;
      },
    );
  }
}
```

---

## Custom Hooks (flutter_hooks)

```dart
import 'package:flutter_hooks/flutter_hooks.dart';

class CounterWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    final controller = useTextEditingController();

    useEffect(() {
      // Configuración
      return () {
        // Limpieza
      };
    }, []);

    return Column(
      children: [
        Text('Count: ${counter.value}'),
        ElevatedButton(
          onPressed: () => counter.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

---

## Patrones de Slivers

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Title'),
        background: Image.network(imageUrl, fit: BoxFit.cover),
      ),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('Item $index')),
        childCount: 100,
      ),
    ),
  ],
)
```

---

## Patrones de Optimización

| Patrón | Implementación |
|--------|----------------|
| **widgets const** | Añadir `const` a widgets estáticos |
| **keys** | Usar `Key` para elementos de lista |
| **select** | `ref.watch(provider.select(...))` |
| **RepaintBoundary** | Aislar repintados costosos |
| **ListView.builder** | Carga lazy para listas |
| **const constructors** | Usar siempre que sea posible |

---

## RepaintBoundary para Optimización

```dart
Widget build(BuildContext context) {
  return RepaintBoundary(
    child: HeavyWidget(),
  );
}
```

---

## Keys en Listas

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      key: ValueKey(items[index].id),
      title: Text(items[index].name),
    );
  },
);
```