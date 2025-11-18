# Screenshots Guide

This folder contains screenshots for the DropX package documentation.

## How to Take Screenshots

1. **Run the example app:**
   ```bash
   cd example
   flutter run
   ```

2. **Navigate to each example screen** from the main menu

3. **Take screenshots** of each screen showing the dropdown in action

## Required Screenshots

### 1. basic_dropdown.png
- Screen: Basic Example
- Show: Dropdown open with items visible
- Focus: Simple, clean dropdown interface

### 2. search_filter.png
- Screen: Search & Filter
- Show: User typing in search field with filtered results
- Focus: Search functionality

### 3. clear_button.png
- Screen: Clear Button
- Show: Dropdown with clear button visible (after selection)
- Focus: Clear button (×) icon

### 4. custom_styling.png
- Screen: Custom Styling
- Show: All three styled dropdowns
- Focus: Different styling options (rounded, dividers, colorful)

### 5. form_validation.png
- Screen: Form Validation
- Show: Form with validation errors visible
- Focus: Integration with Flutter forms

## Screenshot Specifications

- **Device**: Use a phone simulator (iPhone 14 or Pixel 7)
- **Size**: Portrait orientation
- **Format**: PNG
- **Quality**: High resolution (2x or 3x)
- **Background**: Use the default app background

## Tips for Great Screenshots

1. **Show the dropdown open** - Most screenshots should show the dropdown expanded
2. **Use realistic data** - The examples already have good data
3. **Capture key moments** - Show interactions like search, selection, validation
4. **Good lighting** - Use light mode for better visibility
5. **Clean UI** - No debug banners or overlays

## After Taking Screenshots

1. Save files with the exact names listed above
2. Place them in this `screenshots/` folder
3. Optimize file sizes (use tools like TinyPNG)
4. Update the main README.md to reference these screenshots

## Example Commands

```bash
# Run on iOS Simulator
flutter run -d "iPhone 14"

# Run on Android Emulator
flutter run -d emulator-5554

# Take screenshot (iOS)
xcrun simctl io booted screenshot screenshot.png

# Take screenshot (Android)
adb exec-out screencap -p > screenshot.png
```

## Screenshot Checklist

- [ ] basic_dropdown.png
- [ ] search_filter.png
- [ ] clear_button.png
- [ ] custom_styling.png
- [ ] form_validation.png
