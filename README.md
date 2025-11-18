# DropX

A fully customizable dropdown package for Flutter with keyboard navigation support.

[![pub package](https://img.shields.io/pub/v/dropx.svg)](https://pub.dev/packages/dropx)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![style: flutter_lints](https://img.shields.io/badge/style-flutter__lints-blue)](https://pub.dev/packages/flutter_lints)

## Screenshots

<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/birmehto/dropx/main/screenshots/basic_dropdown.png" width="250" alt="Basic Dropdown"/></td>
    <td><img src="https://raw.githubusercontent.com/birmehto/dropx/main/screenshots/search_filter.png" width="250" alt="Search & Filter"/></td>
    <td><img src="https://raw.githubusercontent.com/birmehto/dropx/main/screenshots/clear_button.png" width="250" alt="Clear Button"/></td>
  </tr>
  <tr>
    <td align="center"><b>Basic Dropdown</b></td>
    <td align="center"><b>Search & Filter</b></td>
    <td align="center"><b>Clear Button</b></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/birmehto/dropx/main/screenshots/custom_styling.png" width="250" alt="Custom Styling"/></td>
    <td><img src="https://raw.githubusercontent.com/birmehto/dropx/main/screenshots/form_validation.png" width="250" alt="Form Validation"/></td>
    <td></td>
  </tr>
  <tr>
    <td align="center"><b>Custom Styling</b></td>
    <td align="center"><b>Form Validation</b></td>
    <td></td>
  </tr>
</table>

> 💡 **Try it yourself!** Run the example app to see all features in action:
> ```bash
> cd example && flutter run
> ```

## Features

- ✨ **Full keyboard navigation** - Arrow keys, Enter, Escape
- 🔍 **Built-in search and filtering** - With custom filter support and debouncing
- 📍 **Smart auto-positioning** - Shows above/below based on available space
- 🎨 **Fully customizable styling** - Every color and dimension configurable
- 🌈 **Theme-aware** - Automatically adapts to your app's theme
- ⚡ **Loading states** - Built-in loading indicator support
- 🎯 **Custom item builders** - Complete control over item rendering
- 📱 **Responsive** - Works on all screen sizes
- ♿ **Accessible** - Semantic labels and focus management
- 🖱️ **Click outside to close** - Dropdown closes when clicking outside
- 🔄 **Dynamic updates** - Items automatically update when data changes
- ❌ **Clear button** - Optional clear button to reset selection
- 📝 **Form validation** - Built-in FormField wrapper for easy form integration
- ⏱️ **Search debouncing** - Optimize performance for large lists

## Installation

```yaml
dependencies:
  dropx: ^0.0.2
```

## Usage

```dart
import 'package:dropx/dropx.dart';

Dropx<String>(
  items: ['Apple', 'Banana', 'Cherry'],
  focusNode: FocusNode(),
  hint: 'Select a fruit',
  onSelected: (value) => print(value),
)
```

### Custom styling

```dart
Dropx<String>(
  items: items,
  focusNode: focusNode,
  hint: 'Select',
  onSelected: (value) => print(value),
  config: DropxConfig(
    maxHeight: 400,
    borderRadius: BorderRadius.circular(16),
    showItemDividers: true,
    style: DropxStyle(
      overlayBackgroundColor: Colors.blue.shade50,
      selectedItemBackgroundColor: Colors.blue.shade200,
    ),
  ),
)
```

### Custom items

```dart
Dropx<User>(
  items: users,
  focusNode: focusNode,
  hint: 'Select user',
  displayText: (user) => user.name,
  itemBuilder: (user, isSelected) {
    return ListTile(
      leading: CircleAvatar(child: Text(user.initials)),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  },
  onSelected: (user) => print(user.name),
)
```

### Custom filter

```dart
Dropx<Product>(
  items: products,
  focusNode: focusNode,
  displayText: (product) => product.name,
  customFilter: (product, query) {
    return product.name.contains(query) || product.sku.contains(query);
  },
  onSelected: (product) => print(product.name),
)
```

### Clear button

```dart
Dropx<String>(
  items: items,
  focusNode: focusNode,
  hint: 'Select',
  onSelected: (value) => print(value),
  showClearButton: true,
  onClear: () => print('Selection cleared'),
)
```

### Form validation

```dart
Form(
  key: formKey,
  child: DropxFormField<String>(
    items: ['Option 1', 'Option 2', 'Option 3'],
    hint: 'Select an option',
    validator: (value) {
      if (value == null) return 'Please select an option';
      return null;
    },
    onSaved: (value) => print('Saved: $value'),
  ),
)
```

### Search debouncing

```dart
Dropx<String>(
  items: largeItemList,
  focusNode: focusNode,
  hint: 'Search...',
  onSelected: (value) => print(value),
  config: DropxConfig(
    searchDebounce: Duration(milliseconds: 300),
  ),
)
```

### Async loading

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<String> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = ['Item 1', 'Item 2', 'Item 3'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dropx<String>(
      items: items,
      focusNode: FocusNode(),
      hint: 'Select item',
      onSelected: (value) => print(value),
      isLoading: isLoading,
    );
  }
}
```

## API Reference

### Dropx Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `items` | `List<T>` | List of items to display | Required |
| `focusNode` | `FocusNode` | Focus node for keyboard navigation | Required |
| `onSelected` | `Function(T)` | Callback when item is selected | Required |
| `hint` | `String?` | Placeholder text | `null` |
| `initialValue` | `T?` | Initial selected value | `null` |
| `displayText` | `String Function(T)?` | Custom text extractor | `toString()` |
| `itemBuilder` | `Widget Function(T, bool)?` | Custom item widget builder | `null` |
| `customFilter` | `bool Function(T, String)?` | Custom filter function | `null` |
| `config` | `DropxConfig?` | Configuration options | `DropxConfig()` |
| `header` | `Widget?` | Widget shown at top of dropdown | `null` |
| `footer` | `Widget?` | Widget shown at bottom of dropdown | `null` |
| `emptyWidget` | `Widget?` | Widget shown when no items | Default message |
| `isLoading` | `bool` | Show loading indicator | `false` |
| `enabled` | `bool` | Enable/disable dropdown | `true` |
| `enableSearch` | `bool` | Enable search functionality | `true` |
| `showClearButton` | `bool` | Show clear button when value selected | `false` |
| `onClear` | `VoidCallback?` | Callback when clear button pressed | `null` |
| `onChanged` | `ValueChanged<String>?` | Callback when text changes | `null` |
| `semanticLabel` | `String?` | Accessibility label | `null` |

### DropxConfig Options

See [ARCHITECTURE.md](ARCHITECTURE.md) for complete configuration options.

## Performance Tips

- Use `const` constructors where possible
- Provide `displayText` for complex objects to avoid repeated `toString()` calls
- Use `customFilter` for optimized filtering logic
- Consider pagination for very large lists (>1000 items)

## Accessibility

DropX includes built-in accessibility features:
- Semantic labels for screen readers
- Keyboard navigation support
- Focus management
- High contrast support through theme integration

## More

See [ARCHITECTURE.md](ARCHITECTURE.md) for package details and [example/](example/) for more examples.

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

MIT License - see [LICENSE](LICENSE) file.
