# Performance Guide

This guide provides tips and best practices for optimizing DropX performance in your Flutter applications.

## General Optimization Tips

### 1. Use `const` Constructors

Always use `const` constructors when possible to avoid unnecessary rebuilds:

```dart
// Good
const DropxConfig(
  maxHeight: 300,
  itemHeight: 50,
)

// Bad
DropxConfig(
  maxHeight: 300,
  itemHeight: 50,
)
```

### 2. Provide `displayText` for Complex Objects

Instead of relying on `toString()`, provide a custom `displayText` function:

```dart
// Good
Dropx<User>(
  items: users,
  displayText: (user) => user.name,
  // ...
)

// Bad - toString() called repeatedly
Dropx<User>(
  items: users,
  // ...
)
```

### 3. Optimize Custom Filters

Keep custom filter functions simple and efficient:

```dart
// Good - simple string operations
customFilter: (item, query) {
  return item.name.toLowerCase().contains(query.toLowerCase());
}

// Bad - complex operations in filter
customFilter: (item, query) {
  final regex = RegExp(query, caseSensitive: false);
  return regex.hasMatch(item.name) || 
         regex.hasMatch(item.description) ||
         someExpensiveOperation(item);
}
```

### 4. Limit Item Count

For very large lists (>1000 items), consider:

- Pagination
- Virtual scrolling
- Server-side filtering
- Lazy loading

```dart
// Example: Limit displayed items
final displayedItems = allItems.take(100).toList();

Dropx<Item>(
  items: displayedItems,
  footer: TextButton(
    onPressed: loadMore,
    child: Text('Load more...'),
  ),
  // ...
)
```

## Widget-Specific Optimizations

### 1. Reuse FocusNodes

Don't create new FocusNodes on every build:

```dart
// Good
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _focusNode = FocusNode();
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dropx(
      focusNode: _focusNode,
      // ...
    );
  }
}

// Bad
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dropx(
      focusNode: FocusNode(), // New instance every build!
      // ...
    );
  }
}
```

### 2. Optimize Item Builders

Keep item builders lightweight:

```dart
// Good - simple widget tree
itemBuilder: (item, isSelected) {
  return ListTile(
    title: Text(item.name),
    selected: isSelected,
  );
}

// Bad - complex nested widgets
itemBuilder: (item, isSelected) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(...),
      boxShadow: [...],
    ),
    child: Column(
      children: [
        // Many nested widgets
      ],
    ),
  );
}
```

### 3. Avoid Rebuilding Parent Widgets

Use callbacks that don't trigger unnecessary parent rebuilds:

```dart
// Good - local state update
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? _selected;
  
  @override
  Widget build(BuildContext context) {
    return Dropx(
      onSelected: (value) {
        setState(() => _selected = value);
      },
      // ...
    );
  }
}
```

## Memory Optimization

### 1. Dispose Resources

Always dispose of controllers and focus nodes:

```dart
@override
void dispose() {
  _focusNode.dispose();
  super.dispose();
}
```

### 2. Avoid Memory Leaks

Don't hold references to large objects in closures:

```dart
// Good
Dropx<String>(
  items: items.map((e) => e.id).toList(),
  displayText: (id) => id,
  // ...
)

// Bad - holds reference to entire objects
Dropx<LargeObject>(
  items: largeObjects,
  // ...
)
```

## Search Performance

### 1. Debounce Search Input

For large lists, consider debouncing search:

```dart
Timer? _debounce;

void _onSearchChanged(String query) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();
  _debounce = Timer(const Duration(milliseconds: 300), () {
    // Perform search
  });
}
```

### 2. Use Efficient String Matching

```dart
// Fast
query.toLowerCase().contains(search.toLowerCase())

// Slower
RegExp(search, caseSensitive: false).hasMatch(query)
```

## Rendering Performance

### 1. Set Appropriate Max Height

Limit the number of visible items:

```dart
const DropxConfig(
  maxHeight: 300, // Shows ~6 items at 50px each
  itemHeight: 50,
)
```

### 2. Disable Hover Effects on Mobile

```dart
DropxConfig(
  enableHoverEffect: !isMobile,
)
```

### 3. Reduce Animation Complexity

```dart
const DropxConfig(
  animationDuration: Duration(milliseconds: 150), // Faster
)
```

## Benchmarking

### Measure Performance

Use Flutter DevTools to measure:

1. **Frame rendering time**: Should be <16ms (60fps)
2. **Memory usage**: Watch for leaks
3. **CPU usage**: Should be minimal when idle

### Example Benchmark

```dart
void benchmarkDropdown() {
  final stopwatch = Stopwatch()..start();
  
  // Perform operation
  final filtered = items.where((item) => 
    item.name.contains(query)
  ).toList();
  
  stopwatch.stop();
  print('Filtering took: ${stopwatch.elapsedMilliseconds}ms');
}
```

## Platform-Specific Considerations

### Web
- Limit item count more aggressively
- Use simpler animations
- Test on different browsers

### Mobile
- Optimize for touch interactions
- Consider battery impact
- Test on low-end devices

### Desktop
- Can handle larger lists
- Hover effects are more important
- Keyboard navigation is critical

## Monitoring

### Key Metrics to Watch

1. **Initial render time**: <100ms
2. **Search response time**: <50ms
3. **Scroll performance**: 60fps
4. **Memory footprint**: <10MB for typical use

### Tools

- Flutter DevTools Performance tab
- Memory profiler
- Timeline view
- CPU profiler

## Best Practices Summary

✅ **Do:**
- Use `const` constructors
- Provide `displayText` for objects
- Keep item builders simple
- Dispose resources properly
- Limit visible items
- Use efficient filtering

❌ **Don't:**
- Create new FocusNodes on every build
- Use complex widgets in item builders
- Hold references to large objects
- Perform expensive operations in filters
- Render thousands of items at once
- Forget to dispose resources

## Need Help?

If you're experiencing performance issues:

1. Profile your app with Flutter DevTools
2. Check the [FAQ](README.md#faq) section
3. Open an issue with performance metrics
4. Share a minimal reproducible example
