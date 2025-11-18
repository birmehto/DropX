# DropX Example App

A simple Flutter app demonstrating all features of the DropX package.

## Features Demonstrated

1. **Basic Dropdown** - Simple dropdown with item selection
2. **Clear Button** - Dropdown with clear button to reset selection
3. **Custom Styling** - Custom colors, borders, and styling options
4. **Search Debounce** - Performance optimization for large lists
5. **Form Validation** - Integration with Flutter forms

## Running the Example

```bash
cd example
flutter run
```

## What You'll Learn

- How to use basic DropX widget
- How to enable clear button functionality
- How to customize colors and styling
- How to implement search debouncing
- How to integrate with Flutter forms
- Keyboard navigation shortcuts

## Code Structure

The example is contained in a single `main.dart` file for simplicity. Each example is clearly labeled and demonstrates a specific feature.

## Keyboard Shortcuts

- **↑ ↓** - Navigate items
- **Enter** - Select item
- **Escape** - Close dropdown
- **Type** - Search/filter items

## Quick Code Examples

### Basic Usage
```dart
Dropx<String>(
  items: ['Apple', 'Banana', 'Cherry'],
  focusNode: FocusNode(),
  hint: 'Select a fruit',
  onSelected: (value) => print(value),
)
```

### With Clear Button
```dart
Dropx<String>(
  items: items,
  focusNode: focusNode,
  hint: 'Select',
  onSelected: (value) => print(value),
  showClearButton: true,
  onClear: () => print('Cleared!'),
)
```

### Custom Styling
```dart
Dropx<String>(
  items: items,
  focusNode: focusNode,
  hint: 'Select',
  onSelected: (value) => print(value),
  config: DropxConfig(
    borderRadius: BorderRadius.circular(16),
    showItemDividers: true,
    style: DropxStyle(
      selectedItemBackgroundColor: Colors.blue.shade200,
    ),
  ),
)
```

### Form Validation
```dart
DropxFormField<String>(
  items: items,
  hint: 'Select (required)',
  validator: (value) => value == null ? 'Required' : null,
  onSaved: (value) => print('Saved: $value'),
)
```

## Learn More

- [Main README](../README.md) - Package overview and installation
- [ARCHITECTURE.md](../ARCHITECTURE.md) - Technical details
- [API Documentation](../README.md#api-reference) - Complete API reference
