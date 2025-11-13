// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:dropx/dropx.dart';

class AdvancedExamplePage extends StatefulWidget {
  const AdvancedExamplePage({super.key});

  @override
  State<AdvancedExamplePage> createState() => _AdvancedExamplePageState();
}

class _AdvancedExamplePageState extends State<AdvancedExamplePage> {
  final FocusNode _customColorsFocusNode = FocusNode();
  final FocusNode _minimalFocusNode = FocusNode();
  final FocusNode _dividersFocusNode = FocusNode();
  final FocusNode _customIconsFocusNode = FocusNode();

  final List<String> items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
  ];

  @override
  void dispose() {
    _customColorsFocusNode.dispose();
    _minimalFocusNode.dispose();
    _dividersFocusNode.dispose();
    _customIconsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Styling Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Colors Example
            _buildSectionTitle('Custom Colors'),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: _customColorsFocusNode,
              hint: 'Select with custom colors',
              onSelected: (value) => print('Selected: $value'),
              config: DropxConfig(
                borderRadius: BorderRadius.circular(12),
                elevation: 4,
                itemPadding: const EdgeInsets.all(16),
                style: DropxStyle(
                  overlayBackgroundColor: Colors.amber.shade50,
                  overlayBorderColor: Colors.amber.shade700,
                  overlayBorderWidth: 2,
                  selectedItemBackgroundColor: Colors.amber.shade200,
                  selectedItemTextColor: Colors.amber.shade900,
                  itemTextColor: Colors.brown.shade800,
                  textFieldBorderColor: Colors.amber.shade700,
                  textFieldFocusedBorderColor: Colors.amber.shade900,
                  arrowIconColor: Colors.amber.shade700,
                  arrowIconColorOpen: Colors.amber.shade900,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Minimal Style (No Border)
            _buildSectionTitle('Minimal Style (No Border)'),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: _minimalFocusNode,
              hint: 'Minimal dropdown',
              onSelected: (value) => print('Selected: $value'),
              config: DropxConfig(
                showTextFieldBorder: false,
                borderRadius: BorderRadius.circular(8),
                textFieldContentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                style: DropxStyle(
                  textFieldBackgroundColor: Colors.grey.shade100,
                  overlayBackgroundColor: Colors.white,
                  overlayShadowColor: Colors.black26,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // With Dividers
            _buildSectionTitle('With Item Dividers'),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: _dividersFocusNode,
              hint: 'Select with dividers',
              onSelected: (value) => print('Selected: $value'),
              config: DropxConfig(
                showItemDividers: true,
                dividerThickness: 1,
                dividerIndent: 16,
                dividerEndIndent: 16,
                borderRadius: BorderRadius.circular(8),
                textFieldBorderRadius: BorderRadius.circular(8),
                style: const DropxStyle(
                  dividerColor: Colors.grey,
                  hoveredItemBackgroundColor: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Custom Icons
            _buildSectionTitle('Custom Arrow Icons'),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: _customIconsFocusNode,
              hint: 'Custom icons',
              onSelected: (value) => print('Selected: $value'),
              config: DropxConfig(
                arrowIconClosed: Icons.expand_more_rounded,
                arrowIconOpen: Icons.expand_less_rounded,
                arrowIconSize: 24,
                borderRadius: BorderRadius.circular(16),
                textFieldBorderRadius: BorderRadius.circular(16),
                textFieldBorderWidth: 2,
                textFieldFocusedBorderWidth: 3,
                style: DropxStyle(
                  textFieldBorderColor: Colors.purple.shade300,
                  textFieldFocusedBorderColor: Colors.purple.shade700,
                  arrowIconColor: Colors.purple.shade400,
                  arrowIconColorOpen: Colors.purple.shade700,
                  selectedItemBackgroundColor: Colors.purple.shade100,
                  selectedItemTextColor: Colors.purple.shade900,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Dark Theme Style
            _buildSectionTitle('Dark Theme Style'),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: FocusNode(),
              hint: 'Dark themed dropdown',
              onSelected: (value) => print('Selected: $value'),
              config: DropxConfig(
                borderRadius: BorderRadius.circular(8),
                elevation: 8,
                style: DropxStyle(
                  overlayBackgroundColor: Colors.grey.shade900,
                  overlayBorderColor: Colors.grey.shade700,
                  itemBackgroundColor: Colors.grey.shade900,
                  selectedItemBackgroundColor: Colors.blue.shade900,
                  itemTextColor: Colors.white,
                  selectedItemTextColor: Colors.blue.shade100,
                  textFieldBackgroundColor: Colors.grey.shade800,
                  textFieldBorderColor: Colors.grey.shade700,
                  textFieldFocusedBorderColor: Colors.blue.shade400,
                  textFieldTextColor: Colors.white,
                  textFieldHintColor: Colors.grey.shade400,
                  arrowIconColor: Colors.grey.shade400,
                  arrowIconColorOpen: Colors.blue.shade400,
                  hoveredItemBackgroundColor: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Gradient-like Style
            _buildSectionTitle('Colorful Style'),
            const SizedBox(height: 12),
            Dropx<String>(
              items: items,
              focusNode: FocusNode(),
              hint: 'Colorful dropdown',
              onSelected: (value) => print('Selected: $value'),
              config: DropxConfig(
                borderRadius: BorderRadius.circular(20),
                textFieldBorderRadius: BorderRadius.circular(20),
                elevation: 12,
                itemPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                textFieldContentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                textFieldBorderWidth: 2,
                textFieldFocusedBorderWidth: 3,
                style: DropxStyle(
                  overlayBackgroundColor: Colors.pink.shade50,
                  overlayBorderColor: Colors.pink.shade300,
                  overlayBorderWidth: 2,
                  selectedItemBackgroundColor: Colors.pink.shade200,
                  selectedItemTextColor: Colors.pink.shade900,
                  itemTextColor: Colors.pink.shade800,
                  textFieldBackgroundColor: Colors.pink.shade50,
                  textFieldBorderColor: Colors.pink.shade300,
                  textFieldFocusedBorderColor: Colors.pink.shade600,
                  textFieldTextColor: Colors.pink.shade900,
                  textFieldHintColor: Colors.pink.shade400,
                  arrowIconColor: Colors.pink.shade400,
                  arrowIconColorOpen: Colors.pink.shade700,
                  hoveredItemBackgroundColor: Colors.pink.shade100,
                  splashColor: Colors.pink.shade100,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Info Card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Styling Options',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'DropX provides extensive styling options through DropxConfig and DropxStyle:',
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                    const SizedBox(height: 8),
                    _buildInfoItem('• Custom colors for all elements'),
                    _buildInfoItem('• Border radius and width control'),
                    _buildInfoItem('• Custom icons and sizes'),
                    _buildInfoItem('• Item dividers and hover effects'),
                    _buildInfoItem('• Text styles and padding'),
                    _buildInfoItem('• Shadow and elevation'),
                    const SizedBox(height: 8),
                    Text(
                      'All colors are optional - if not specified, the dropdown will use your app\'s theme colors.',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Text(
        text,
        style: TextStyle(color: Colors.blue.shade800, fontSize: 13),
      ),
    );
  }
}
