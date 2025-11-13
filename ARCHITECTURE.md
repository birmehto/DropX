# DropX Architecture

## Overview

DropX has been refactored into a modular, maintainable architecture with complete theme integration.

## File Structure

```
lib/
├── dropx.dart                      # Main library export file
└── src/
    ├── dropx_widget.dart      # Main dropdown widget
    ├── dropx_config.dart        # Configuration class (layout & behavior)
    ├── dropx_style.dart         # Styling class (colors & appearance)
    ├── dropx_controller.dart    # State management
    ├── dropx_overlay.dart       # Overlay content builder
    └── dropx_keyboard_handler.dart       # Keyboard navigation logic
```

## Components

### 1. Dropx (dropx_widget.dart)
The main widget that users interact with. Handles:
- Widget lifecycle
- Focus management
- Overlay creation and positioning
- Integration with other components

### 2. DropxConfig (dropx_config.dart)
Configuration class for customizing dropdown layout and behavior:
- Border radius, elevation, dimensions
- Padding and text styles
- Animation settings
- Item heights and icon sizes
- Dividers, borders, and hover effects
- References DropxStyle for color customization

### 3. DropxStyle (dropx_style.dart)
Comprehensive color customization class:
- All color properties for every element
- Overlay, item, text field, and icon colors
- Interaction colors (hover, splash, highlight)
- Optional - falls back to theme colors when not specified

### 4. DropxController (dropx_controller.dart)
Manages dropdown state and business logic:
- Item filtering and search
- Selection state
- Navigation between items
- Scroll position management

### 5. DropxOverlay (dropx_overlay.dart)
Builds the dropdown overlay content:
- Item list rendering
- Empty state display
- Header and footer integration
- Theme-aware styling

### 6. DropxKeyboardHandler (dropx_keyboard_handler.dart)
Handles all keyboard interactions:
- Arrow key navigation
- Enter key selection
- Escape key dismissal
- Event result handling

## Theme Integration

All colors are derived from Flutter's `ColorScheme`:

| Element | Color Source |
|---------|-------------|
| Background | `colorScheme.surface` |
| Text | `colorScheme.onSurface` |
| Selected Background | `colorScheme.primaryContainer` |
| Selected Text | `colorScheme.onPrimaryContainer` |
| Border | `colorScheme.outline` |
| Focus Border | `colorScheme.primary` |
| Disabled | `colorScheme.onSurface.withOpacity(0.12)` |

## Benefits of Refactoring

1. **Separation of Concerns**: Each file has a single, clear responsibility
2. **Maintainability**: Easier to locate and fix bugs
3. **Testability**: Components can be tested independently
4. **Theme-Aware**: Automatically adapts to app theme when colors not specified
5. **Fully Customizable**: Every color and dimension can be customized via DropxStyle
6. **Extensibility**: Easy to add new features without affecting existing code
7. **Reusability**: Components can be reused in other contexts
8. **Progressive Enhancement**: Start with defaults, customize only what you need

## Migration from Old Code

The API remains largely the same, with these improvements:

### Old Way (with hardcoded colors):
```dart
Dropx(
  items: items,
  focusNode: focusNode,
  hint: 'Select',
  onSelected: (value) {},
  dropdownWidth: 300,
  dropdownMaxHeight: 400,
  minSearchLength: 2,
);
```

### New Way (theme-aware with config):
```dart
Dropx(
  items: items,
  focusNode: focusNode,
  hint: 'Select',
  onSelected: (value) {},
  config: DropxConfig(
    width: 300,
    maxHeight: 400,
    minSearchLength: 2,
  ),
);
```

## Styling System

The styling system uses a two-tier approach:

1. **DropxConfig**: Controls layout, dimensions, and behavior
   - Border radius, padding, dimensions
   - Icons, dividers, animations
   - Text styles
   - Contains optional DropxStyle

2. **DropxStyle**: Controls all colors
   - Every color property is optional
   - Falls back to theme colors when not specified
   - Allows complete visual customization

This separation allows users to:
- Use theme colors by default (no config needed)
- Customize layout without touching colors
- Customize colors without touching layout
- Mix and match as needed

## Future Enhancements

Potential areas for future development:
- Multi-select support
- Grouped items
- Virtual scrolling for large lists
- Async item loading
- Accessibility improvements
- Animation customization
- Gradient backgrounds
- Custom shapes and clipping
