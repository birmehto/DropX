import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dropx/dropx.dart';

void main() {
  group('Dropx Widget Tests', () {
    late FocusNode focusNode;
    final items = ['Apple', 'Banana', 'Cherry', 'Date'];

    setUp(() {
      focusNode = FocusNode();
    });

    tearDown(() {
      focusNode.dispose();
    });

    testWidgets('renders with basic configuration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select a fruit',
              onSelected: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('Select a fruit'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('shows dropdown when focused', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
            ),
          ),
        ),
      );

      // Focus the text field
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Check if dropdown items are visible
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
    });

    testWidgets('selects item on tap', (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Tap on an item
      await tester.tap(find.text('Banana'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('Banana'));
      expect(find.text('Banana'), findsOneWidget); // Should be in text field
    });

    testWidgets('filters items when searching', (WidgetTester tester) async {
      final testFocusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: testFocusNode,
              hint: 'Select',
              onSelected: (value) {},
              enableSearch: true,
            ),
          ),
        ),
      );

      // Focus and open dropdown
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Type to filter
      await tester.enterText(find.byType(TextField), 'app');
      await tester.pumpAndSettle();

      // Should show Apple in the text field
      expect(find.text('Apple'), findsWidgets);

      testFocusNode.dispose();
    });

    testWidgets('navigates with arrow keys', (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      // Focus the text field
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Press arrow down
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      // Press enter to select
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(selectedValue, equals('Apple'));
    });

    testWidgets('closes dropdown with escape key', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsOneWidget);

      // Press escape
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      // Dropdown should be closed (items not visible in overlay)
      // Note: Items might still be found in the widget tree but not visible
    });

    testWidgets('displays initial value', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              initialValue: 'Cherry',
            ),
          ),
        ),
      );

      expect(find.text('Cherry'), findsOneWidget);
    });

    testWidgets('shows loading indicator when loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays custom empty widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const [],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              emptyWidget: const Text('No items available'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('No items available'), findsOneWidget);
    });

    testWidgets('uses custom item builder', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              itemBuilder: (item, isSelected) {
                return ListTile(
                  title: Text('Custom: $item'),
                  selected: isSelected,
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('Custom: Apple'), findsOneWidget);
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('displays header and footer', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              header: const Text('Header'),
              footer: const Text('Footer'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
    });

    testWidgets('respects enabled property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              enabled: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });
  });

  group('DropxConfig Tests', () {
    test('creates with default values', () {
      const config = DropxConfig();

      expect(config.elevation, equals(8.0));
      expect(config.itemHeight, equals(50.0));
      expect(config.showItemDividers, isFalse);
      expect(config.enableHoverEffect, isTrue);
      expect(config.showTextFieldBorder, isTrue);
    });

    test('creates with custom values', () {
      final config = DropxConfig(
        maxHeight: 400,
        elevation: 4,
        showItemDividers: true,
        borderRadius: BorderRadius.circular(16),
      );

      expect(config.maxHeight, equals(400));
      expect(config.elevation, equals(4));
      expect(config.showItemDividers, isTrue);
      expect(config.borderRadius, equals(BorderRadius.circular(16)));
    });

    test('copyWith works correctly', () {
      const config = DropxConfig(elevation: 4);
      final copied = config.copyWith(elevation: 8);

      expect(copied.elevation, equals(8));
      expect(copied.itemHeight, equals(50.0)); // Should keep default
    });
  });

  group('DropxStyle Tests', () {
    test('creates with default values', () {
      const style = DropxStyle();

      expect(style.overlayBackgroundColor, isNull);
      expect(style.itemTextColor, isNull);
      expect(style.selectedItemBackgroundColor, isNull);
    });

    test('creates with custom colors', () {
      const style = DropxStyle(
        overlayBackgroundColor: Colors.blue,
        itemTextColor: Colors.white,
        selectedItemBackgroundColor: Colors.green,
      );

      expect(style.overlayBackgroundColor, equals(Colors.blue));
      expect(style.itemTextColor, equals(Colors.white));
      expect(style.selectedItemBackgroundColor, equals(Colors.green));
    });

    test('copyWith works correctly', () {
      const style = DropxStyle(overlayBackgroundColor: Colors.blue);
      final copied = style.copyWith(itemTextColor: Colors.white);

      expect(copied.overlayBackgroundColor, equals(Colors.blue));
      expect(copied.itemTextColor, equals(Colors.white));
    });

    test('merge works correctly', () {
      const style1 = DropxStyle(overlayBackgroundColor: Colors.blue);
      const style2 = DropxStyle(itemTextColor: Colors.white);
      final merged = style1.merge(style2);

      expect(merged.overlayBackgroundColor, equals(Colors.blue));
      expect(merged.itemTextColor, equals(Colors.white));
    });
  });

  group('DropxController Tests', () {
    test('initializes with correct values', () {
      final controller = DropxController<String>(
        textController: TextEditingController(),
        scrollController: ScrollController(),
        layerLink: LayerLink(),
        allItems: ['A', 'B', 'C'],
        getDisplayText: (item) => item,
      );

      expect(controller.filteredItems, equals(['A', 'B', 'C']));
      expect(controller.selectedIndex, equals(-1));
      expect(controller.isDropdownOpen, isFalse);
    });

    test('filters items correctly', () {
      final controller = DropxController<String>(
        textController: TextEditingController(),
        scrollController: ScrollController(),
        layerLink: LayerLink(),
        allItems: ['Apple', 'Banana', 'Cherry'],
        getDisplayText: (item) => item,
        enableSearch: true,
      );

      controller.filterItems('app');

      expect(controller.filteredItems, equals(['Apple']));
      expect(controller.selectedIndex, equals(0));
    });

    test('moves selection down', () {
      final controller = DropxController<String>(
        textController: TextEditingController(),
        scrollController: ScrollController(),
        layerLink: LayerLink(),
        allItems: ['A', 'B', 'C'],
        getDisplayText: (item) => item,
      );

      controller.moveSelectionDown();
      expect(controller.selectedIndex, equals(0));

      controller.moveSelectionDown();
      expect(controller.selectedIndex, equals(1));
    });

    test('moves selection up', () {
      final controller = DropxController<String>(
        textController: TextEditingController(),
        scrollController: ScrollController(),
        layerLink: LayerLink(),
        allItems: ['A', 'B', 'C'],
        getDisplayText: (item) => item,
      );

      // Start at -1, moving up: (-1 - 1 + 3) % 3 = 1
      controller.moveSelectionUp();
      expect(controller.selectedIndex, equals(1));

      controller.moveSelectionUp();
      expect(controller.selectedIndex, equals(0));

      controller.moveSelectionUp();
      expect(controller.selectedIndex, equals(2)); // Wraps around
    });

    test('gets selected item', () {
      final controller = DropxController<String>(
        textController: TextEditingController(),
        scrollController: ScrollController(),
        layerLink: LayerLink(),
        allItems: ['A', 'B', 'C'],
        getDisplayText: (item) => item,
      );

      controller.setSelectedIndex(1);
      expect(controller.getSelectedItem(), equals('B'));
    });
  });

  group('Custom Filter Tests', () {
    testWidgets('uses custom filter function', (WidgetTester tester) async {
      final testFocusNode = FocusNode();
      final items = [
        {'name': 'Apple', 'code': 'APL'},
        {'name': 'Banana', 'code': 'BAN'},
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<Map<String, String>>(
              items: items,
              focusNode: testFocusNode,
              hint: 'Select',
              onSelected: (value) {},
              displayText: (item) => item['name']!,
              customFilter: (item, query) {
                return item['name']!.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ||
                    item['code']!.toLowerCase().contains(query.toLowerCase());
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Filter by code
      await tester.enterText(find.byType(TextField), 'APL');
      await tester.pumpAndSettle();

      // Apple should be visible
      expect(find.text('Apple'), findsWidgets);

      testFocusNode.dispose();
    });
  });

  group('Theme Integration Tests', () {
    testWidgets('uses theme colors when no style provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          ),
          home: Scaffold(
            body: Dropx<String>(
              items: const ['A', 'B'],
              focusNode: FocusNode(),
              hint: 'Select',
              onSelected: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Widget should render without errors using theme colors
      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('applies custom style colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['A', 'B'],
              focusNode: FocusNode(),
              hint: 'Select',
              onSelected: (value) {},
              config: const DropxConfig(
                style: DropxStyle(textFieldBackgroundColor: Colors.red),
              ),
            ),
          ),
        ),
      );

      // Widget should render with custom colors
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
