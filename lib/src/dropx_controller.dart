import 'package:flutter/material.dart';

/// Controller for managing Dropx state and behavior
class DropxController<T> {
  final TextEditingController textController;
  final ScrollController scrollController;
  final LayerLink layerLink;
  final List<T> allItems;
  final String Function(T) getDisplayText;
  final bool Function(T, String)? customFilter;
  final bool enableSearch;
  final int minSearchLength;

  List<T> _filteredItems;
  int _selectedIndex = -1;
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  DropxController({
    required this.textController,
    required this.scrollController,
    required this.layerLink,
    required this.allItems,
    required this.getDisplayText,
    this.customFilter,
    this.enableSearch = true,
    this.minSearchLength = 0,
  }) : _filteredItems = allItems;

  List<T> get filteredItems => _filteredItems;
  int get selectedIndex => _selectedIndex;
  bool get isDropdownOpen => _isDropdownOpen;
  OverlayEntry? get overlayEntry => _overlayEntry;

  void setOverlayEntry(OverlayEntry? entry) {
    _overlayEntry = entry;
  }

  void setDropdownOpen(bool isOpen) {
    _isDropdownOpen = isOpen;
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
  }

  void updateFilteredItems(List<T> items) {
    _filteredItems = items;
  }

  bool _defaultFilter(T item, String query) {
    return getDisplayText(item).toLowerCase().contains(query.toLowerCase());
  }

  void filterItems(String query) {
    if (!enableSearch) return;

    if (query.isEmpty || query.length < minSearchLength) {
      _filteredItems = allItems;
    } else {
      final filterFunc = customFilter ?? _defaultFilter;
      _filteredItems = allItems
          .where((item) => filterFunc(item, query))
          .toList();
    }
    _selectedIndex = _filteredItems.isNotEmpty ? 0 : -1;
  }

  void moveSelectionDown() {
    if (_filteredItems.isNotEmpty) {
      _selectedIndex = (_selectedIndex + 1) % _filteredItems.length;
    }
  }

  void moveSelectionUp() {
    if (_filteredItems.isNotEmpty) {
      _selectedIndex =
          (_selectedIndex - 1 + _filteredItems.length) % _filteredItems.length;
    }
  }

  T? getSelectedItem() {
    if (_selectedIndex >= 0 && _selectedIndex < _filteredItems.length) {
      return _filteredItems[_selectedIndex];
    }
    return null;
  }

  void scrollToSelected(double itemHeight, Duration duration, Curve curve) {
    if (_selectedIndex >= 0 && scrollController.hasClients) {
      final targetOffset = _selectedIndex * itemHeight;
      final maxScroll = scrollController.position.maxScrollExtent;
      final minScroll = scrollController.position.minScrollExtent;

      final offset = targetOffset.clamp(minScroll, maxScroll);

      scrollController.animateTo(offset, duration: duration, curve: curve);
    }
  }

  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
