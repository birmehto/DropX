import 'package:dropx/dropx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dropx Improvements Tests', () {
    testWidgets('shows clear button when enabled and has value', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['Apple', 'Banana'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              showClearButton: true,
              initialValue: 'Apple',
            ),
          ),
        ),
      );

      // Clear button should be visible
      expect(find.byIcon(Icons.clear), findsOneWidget);

      focusNode.dispose();
    });

    testWidgets('clear button clears selection', (WidgetTester tester) async {
      final focusNode = FocusNode();
      bool cleared = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['Apple', 'Banana'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              showClearButton: true,
              initialValue: 'Apple',
              onClear: () => cleared = true,
            ),
          ),
        ),
      );

      // Tap clear button
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();

      expect(cleared, isTrue);

      focusNode.dispose();
    });

    testWidgets('onChanged callback is called', (WidgetTester tester) async {
      final focusNode = FocusNode();
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['Apple', 'Banana'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              enableSearch: true,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'test');
      await tester.pumpAndSettle();

      expect(changedValue, equals('test'));

      focusNode.dispose();
    });

    testWidgets('DropxFormField validates correctly', (
      WidgetTester tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: DropxFormField<String>(
                items: const ['Apple', 'Banana'],
                hint: 'Select',
                validator: (value) {
                  if (value == null) return 'Required';
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      // Validate without selection
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('semantic label is applied', (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropx<String>(
              items: const ['Apple', 'Banana'],
              focusNode: focusNode,
              hint: 'Select',
              onSelected: (value) {},
              semanticLabel: 'Fruit selector',
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Fruit selector'), findsOneWidget);

      focusNode.dispose();
    });
  });
}
