import 'package:dropx/dropx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Advanced Dropx Tests', () {
    testWidgets('handles empty items list gracefully', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const [],
              focusNode: FocusNode(),
              hint: 'Select',
              onSelected: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('No items found'), findsOneWidget);
    });

    testWidgets('handles very long item lists', (tester) async {
      final items = List.generate(100, (i) => 'Item $i');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: items,
              focusNode: FocusNode(),
              hint: 'Select',
              onSelected: (value) {},
              config: const DropxConfig(maxHeight: 300),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Should render without errors
      expect(find.text('Item 0'), findsOneWidget);
    });

    testWidgets('preserves selection after filtering', (tester) async {
      String? selectedValue;
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['Apple', 'Banana', 'Cherry'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) => selectedValue = value,
              enableSearch: true,
            ),
          ),
        ),
      );

      // Open and select
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Banana'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('Banana'));
      expect(find.text('Banana'), findsOneWidget);

      focusNode.dispose();
    });

    testWidgets('handles rapid keyboard navigation', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['A', 'B', 'C', 'D', 'E'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Rapid navigation
      for (int i = 0; i < 10; i++) {
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      }
      await tester.pumpAndSettle();

      // Should handle without errors
      expect(find.byType(TextField), findsOneWidget);

      focusNode.dispose();
    });

    testWidgets('handles special characters in search', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['Test@123', 'Item#456', 'Value\$789'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              enableSearch: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '@');
      await tester.pumpAndSettle();

      // Should filter correctly
      expect(find.text('Test@123'), findsWidgets);

      focusNode.dispose();
    });

    testWidgets('updates when items list changes', (tester) async {
      final focusNode = FocusNode();
      List<String> items = ['A', 'B', 'C'];

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    Dropx<String>(
                      items: items,
                      focusNode: focusNode,
                      hint: 'Select',
                      onSelected: (value) {},
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          items = ['X', 'Y', 'Z'];
                        });
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(find.text('A'), findsOneWidget);

      // Close dropdown first by tapping outside
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Update items
      await tester.tap(find.text('Update'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Open dropdown again to see updated items
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(find.text('X'), findsOneWidget);

      focusNode.dispose();
    });

    testWidgets('handles null displayText gracefully', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String?>(
              items: const ['A', 'B', null],
              focusNode: FocusNode(),
              hint: 'Select',
              onSelected: (value) {},
              displayText: (item) => item ?? 'None',
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('None'), findsOneWidget);
    });

    testWidgets('respects minSearchLength config', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['Apple', 'Banana', 'Cherry'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              config: const DropxConfig(minSearchLength: 3),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Type less than minSearchLength
      await tester.enterText(find.byType(TextField), 'ap');
      await tester.pumpAndSettle();

      // Should show all items (not filtered yet)
      expect(find.text('Apple'), findsWidgets);
      expect(find.text('Banana'), findsWidgets);

      focusNode.dispose();
    });

    testWidgets('handles complex object filtering', (tester) async {
      final users = [
        {'name': 'John', 'age': 30, 'city': 'NYC'},
        {'name': 'Jane', 'age': 25, 'city': 'LA'},
        {'name': 'Bob', 'age': 35, 'city': 'Chicago'},
      ];

      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<Map<String, dynamic>>(
              items: users,
              focusNode: focusNode,
              hint: 'Select user',
              displayText: (user) => user['name'] as String,
              customFilter: (user, query) {
                final q = query.toLowerCase();
                return (user['name'] as String).toLowerCase().contains(q) ||
                    (user['city'] as String).toLowerCase().contains(q);
              },
              onSelected: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'nyc');
      await tester.pumpAndSettle();

      expect(find.text('John'), findsWidgets);

      focusNode.dispose();
    });

    testWidgets('handles arrow up from first item', (tester) async {
      String? selectedValue;
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['A', 'B', 'C'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Move down to first item
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      // Move up (should wrap to last)
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      // Should select last item
      expect(selectedValue, equals('C'));

      focusNode.dispose();
    });

    testWidgets('clears text field when selection is cleared', (tester) async {
      final focusNode = FocusNode();
      String? selectedValue = 'Apple';

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    Dropx<String>(
                      items: const ['Apple', 'Banana', 'Cherry'],
                      focusNode: focusNode,
                      hint: 'Select',
                      onSelected: (value) {
                        setState(() => selectedValue = value);
                      },
                      initialValue: selectedValue,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => selectedValue = null);
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('Apple'), findsOneWidget);

      await tester.tap(find.text('Clear'));
      await tester.pumpAndSettle();

      // Should show hint
      expect(find.text('Select'), findsOneWidget);

      focusNode.dispose();
    });
  });

  group('DropxConfig Edge Cases', () {
    test('handles extreme values', () {
      const config = DropxConfig(
        maxHeight: 10000,
        itemHeight: 1,
        elevation: 100,
      );

      expect(config.maxHeight, equals(10000));
      expect(config.itemHeight, equals(1));
      expect(config.elevation, equals(100));
    });

    test('copyWith preserves null values correctly', () {
      const config = DropxConfig(elevation: 4);
      final copied = config.copyWith();

      expect(copied.elevation, equals(4));
      expect(copied.maxHeight, equals(config.maxHeight));
    });
  });

  group('DropxStyle Edge Cases', () {
    test('merge handles all null values', () {
      const style1 = DropxStyle();
      const style2 = DropxStyle();
      final merged = style1.merge(style2);

      expect(merged.overlayBackgroundColor, isNull);
      expect(merged.itemTextColor, isNull);
    });

    test('merge prioritizes second style', () {
      const style1 = DropxStyle(
        overlayBackgroundColor: Colors.red,
        itemTextColor: Colors.blue,
      );
      const style2 = DropxStyle(overlayBackgroundColor: Colors.green);
      final merged = style1.merge(style2);

      expect(merged.overlayBackgroundColor, equals(Colors.green));
      expect(merged.itemTextColor, equals(Colors.blue));
    });
  });

  group('Performance Tests', () {
    testWidgets('handles rapid open/close cycles', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['A', 'B', 'C'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
            ),
          ),
        ),
      );

      // Rapid open/close
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        await tester.pumpAndSettle();
      }

      expect(find.byType(TextField), findsOneWidget);

      focusNode.dispose();
    });
  });
}
