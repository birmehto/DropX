import 'package:flutter/material.dart';
import 'package:dropx/dropx.dart';

class SimpleExamplePage extends StatefulWidget {
  const SimpleExamplePage({super.key});

  @override
  State<SimpleExamplePage> createState() => _SimpleExamplePageState();
}

class _SimpleExamplePageState extends State<SimpleExamplePage> {
  final FocusNode _basicFocusNode = FocusNode();
  final FocusNode _customFocusNode = FocusNode();
  final FocusNode _searchFocusNode = FocusNode();

  final List<String> fruits = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
  ];

  final List<User> users = [
    User('John Doe', 'john@example.com'),
    User('Jane Smith', 'jane@example.com'),
    User('Bob Johnson', 'bob@example.com'),
    User('Alice Williams', 'alice@example.com'),
  ];

  String? selectedFruit;
  User? selectedUser;

  @override
  void dispose() {
    _basicFocusNode.dispose();
    _customFocusNode.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DropX Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Example
            Text(
              'Basic Dropdown',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Dropx<String>(
              items: fruits,
              focusNode: _basicFocusNode,
              hint: 'Select a fruit',
              onSelected: (value) {
                setState(() {
                  selectedFruit = value;
                });
              },
              initialValue: selectedFruit,
            ),
            if (selectedFruit != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Selected: $selectedFruit'),
              ),
            const SizedBox(height: 32),

            // Custom Styled Example
            Text(
              'Custom Styled Dropdown',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Dropx<String>(
              items: fruits,
              focusNode: _customFocusNode,
              hint: 'Choose your favorite',
              onSelected: (value) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('You selected: $value')));
              },
              config: const DropxConfig(
                maxHeight: 250,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                elevation: 4,
                itemPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              header: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: const Text(
                  'Available Fruits',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Custom Item Builder Example
            Text(
              'Custom Item Builder',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Dropx<User>(
              items: users,
              focusNode: _searchFocusNode,
              hint: 'Search users',
              displayText: (user) => user.name,
              itemBuilder: (user, isSelected) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  color: isSelected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          user.initials,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              user.email,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer
                                          .withValues(alpha: 0.7)
                                    : Theme.of(context).colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              onSelected: (user) {
                setState(() {
                  selectedUser = user;
                });
              },
              initialValue: selectedUser,
              config: const DropxConfig(itemHeight: 72),
            ),
            if (selectedUser != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Selected: ${selectedUser!.name}'),
              ),
            const SizedBox(height: 32),

            // Instructions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keyboard Navigation',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('• Arrow Up/Down: Navigate items'),
                    const Text('• Enter: Select item'),
                    const Text('• Escape: Close dropdown'),
                    const Text('• Type to search/filter'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }
}
