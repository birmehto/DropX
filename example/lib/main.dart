import 'package:flutter/material.dart';

import 'screens/basic_example_screen.dart';
import 'screens/clear_button_screen.dart';
import 'screens/custom_styling_screen.dart';
import 'screens/form_validation_screen.dart';
import 'screens/search_filter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DropX Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExampleListScreen(),
    );
  }
}

class ExampleListScreen extends StatelessWidget {
  const ExampleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DropX Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExampleCard(
            context,
            title: '1. Basic Dropdown',
            description: 'Simple dropdown with item selection',
            icon: Icons.arrow_drop_down_circle,
            color: Colors.blue,
            screen: const BasicExampleScreen(),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            title: '2. Search & Filter',
            description: 'Dropdown with search functionality',
            icon: Icons.search,
            color: Colors.green,
            screen: const SearchFilterScreen(),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            title: '3. Clear Button',
            description: 'Dropdown with clear button',
            icon: Icons.clear,
            color: Colors.orange,
            screen: const ClearButtonScreen(),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            title: '4. Custom Styling',
            description: 'Custom colors and styling',
            icon: Icons.palette,
            color: Colors.purple,
            screen: const CustomStylingScreen(),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            title: '5. Form Validation',
            description: 'Integration with Flutter forms',
            icon: Icons.check_circle,
            color: Colors.red,
            screen: const FormValidationScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
