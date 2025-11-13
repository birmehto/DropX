# DropX

A fully customizable dropdown package for Flutter with keyboard navigation support.

[![pub package](https://img.shields.io/pub/v/dropx.svg)](https://pub.dev/packages/dropx)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Features

- Full keyboard navigation
- Built-in search and filtering
- Smart positioning
- Custom styling
- Loading states

## Installation

```yaml
dependencies:
  dropx: ^0.0.1
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

## More

See [ARCHITECTURE.md](ARCHITECTURE.md) for package details and [example/](example/) for more examples.

## License

MIT License - see [LICENSE](LICENSE) file.
