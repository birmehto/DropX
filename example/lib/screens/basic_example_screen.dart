import 'package:dropx/dropx.dart';
import 'package:flutter/material.dart';

class BasicExampleScreen extends StatefulWidget {
  const BasicExampleScreen({super.key});

  @override
  State<BasicExampleScreen> createState() => _BasicExampleScreenState();
}

class _BasicExampleScreenState extends State<BasicExampleScreen> {
  final FocusNode _focusNode = FocusNode();
  String? selectedFruit;

  final List<String> fruits = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
  ];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Dropdown'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Your Favorite Fruit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose from the dropdown below',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            Dropx<String>(
              items: fruits,
              focusNode: _focusNode,
              hint: 'Select a fruit',
              onSelected: (value) {
                setState(() => selectedFruit = value);
              },
              initialValue: selectedFruit,
            ),
            if (selectedFruit != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'You selected: $selectedFruit',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),
            _buildKeyboardHints(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboardHints() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.keyboard, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(
                'Keyboard Shortcuts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildHint('↑ ↓', 'Navigate items'),
          _buildHint('Enter', 'Select item'),
          _buildHint('Esc', 'Close dropdown'),
          _buildHint('Type', 'Search items'),
        ],
      ),
    );
  }

  Widget _buildHint(String key, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Text(
              key,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(description, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
