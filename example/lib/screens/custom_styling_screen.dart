import 'package:dropx/dropx.dart';
import 'package:flutter/material.dart';

class CustomStylingScreen extends StatefulWidget {
  const CustomStylingScreen({super.key});

  @override
  State<CustomStylingScreen> createState() => _CustomStylingScreenState();
}

class _CustomStylingScreenState extends State<CustomStylingScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  final List<String> items = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Styling'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rounded Style',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: _focusNode1,
              hint: 'Select an option',
              onSelected: (value) {},
              config: DropxConfig(
                borderRadius: BorderRadius.circular(20),
                textFieldBorderRadius: BorderRadius.circular(20),
                style: DropxStyle(
                  selectedItemBackgroundColor: Colors.purple.shade100,
                  textFieldBorderColor: Colors.purple,
                  textFieldFocusedBorderColor: Colors.purple.shade700,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'With Dividers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: _focusNode2,
              hint: 'Select an option',
              onSelected: (value) {},
              config: DropxConfig(
                showItemDividers: true,
                borderRadius: BorderRadius.circular(12),
                style: DropxStyle(
                  selectedItemBackgroundColor: Colors.blue.shade100,
                  textFieldBorderColor: Colors.blue,
                  textFieldFocusedBorderColor: Colors.blue.shade700,
                  dividerColor: Colors.blue.shade200,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Colorful Style',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: _focusNode3,
              hint: 'Select an option',
              onSelected: (value) {},
              config: DropxConfig(
                borderRadius: BorderRadius.circular(16),
                textFieldBorderRadius: BorderRadius.circular(16),
                elevation: 12,
                style: DropxStyle(
                  overlayBackgroundColor: Colors.pink.shade50,
                  selectedItemBackgroundColor: Colors.pink.shade200,
                  textFieldBackgroundColor: Colors.pink.shade50,
                  textFieldBorderColor: Colors.pink.shade300,
                  textFieldFocusedBorderColor: Colors.pink.shade700,
                  arrowIconColor: Colors.pink.shade700,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.palette, color: Colors.amber.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Customize colors, borders, shadows, and more using DropxConfig and DropxStyle',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
