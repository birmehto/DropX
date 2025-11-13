import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Handles keyboard events for Dropx navigation
class DropxKeyboardHandler {
  final Function() onArrowDown;
  final Function() onArrowUp;
  final Function() onEnter;
  final Function() onEscape;
  final bool Function() isDropdownOpen;

  DropxKeyboardHandler({
    required this.onArrowDown,
    required this.onArrowUp,
    required this.onEnter,
    required this.onEscape,
    required this.isDropdownOpen,
  });

  KeyEventResult handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      onArrowDown();
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      onArrowUp();
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (isDropdownOpen()) {
        onEnter();
        return KeyEventResult.handled;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
      if (isDropdownOpen()) {
        onEscape();
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }
}
