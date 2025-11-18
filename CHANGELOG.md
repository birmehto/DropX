## 0.0.2

### New Features
- Added optional clear button (`showClearButton`, `onClear`) to reset selection.
- Introduced `DropxFormField` with full form validation support.
- Added configurable search debouncing for better performance.
- New `onChanged` callback for real-time text input tracking.
- Added `semanticLabel` for improved accessibility.
- Exported `DropxKeyboardHandler` for custom keyboard logic.
- Dropdown now closes when tapping outside.
- Items automatically update when the items list changes.
- Search query is preserved during data refresh.

### Bug Fixes
- Fixed items not updating after clearing search text.
- Fixed real-time filtered item updates.
- Fixed dropdown not updating when items changed.
- Fixed filtered list not refreshing on data updates.
- Removed unused `verticalOffset` parameter.

### Documentation
- Updated README with new features and examples.
- Added clear button example.
- Added `IMPROVEMENTS.md` with detailed feature explanations.
- Improved API reference table.
- Added extensive tests covering all new features.

### Testing
- Added `dropx_improvements_test.dart`.
- Tests for clear button, form validation, semantic labels, and callbacks.

---

## 0.0.1

### Initial Release
A fully customizable, theme-aware dropdown widget for Flutter.

### Features
- Keyboard navigation (Arrow keys, Enter, Escape).
- Built-in search and custom filtering.
- Smart auto-positioning (above/below).
- Theme-aware styling without hardcoded colors.
- Loading and empty state support.

### Architecture
- `Dropx` — main widget.
- `DropxConfig` — layout/behavior config.
- `DropxStyle` — full styling control.
- `DropxController` — state management.
- `DropxOverlay` — overlay builder.
- `DropxKeyboardHandler` — keyboard logic.

### Customization
- Custom item builders.
- Header/footer injection.
- Full color customization.
- Dimensions, radius, padding configs.
- Icon customization.
- Item dividers.
- Hover effects.
- Text field styling.

### Developer Experience
- Full documentation and examples.
- Type-safe generics.
- Extensive test coverage.
- Performance optimizations.

### Documentation & Testing
- README, ARCHITECTURE, CONTRIBUTING, PERFORMANCE guides.
- 3 example pages.
- Comprehensive widget & performance tests.

### Development
- GitHub Actions CI.
- Automated tests and coverage.
- Issue/PR templates.
- Security policy.
