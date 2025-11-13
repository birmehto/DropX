import 'package:flutter/material.dart';
import 'dropx_config.dart';
import 'dropx_controller.dart';
import 'dropx_overlay.dart';
import 'dropx_keyboard_handler.dart';

/// A highly customizable dropdown widget with keyboard navigation support.
///
/// Features:
/// - Full keyboard navigation (Arrow keys, Enter, Escape, Tab)
/// - Search/filter functionality
/// - Custom item builders
/// - Auto-positioning (shows above/below based on available space)
/// - Loading and empty states
/// - Custom header and footer
/// - Configurable width and height
/// - Theme-aware colors (no hardcoded colors)
class Dropx<T> extends StatefulWidget {
  /// List of items to display in the dropdown
  final List<T> items;

  /// Focus node for keyboard navigation
  final FocusNode focusNode;

  /// Callback when an item is selected
  final Function(T) onSelected;

  /// Hint text to display when no item is selected
  final String hint;

  /// Function to convert item to display text
  final String Function(T)? displayText;

  /// Custom builder for dropdown items
  final Widget Function(T, bool)? itemBuilder;

  /// Optional header widget (e.g., table headers)
  final Widget? header;

  /// Optional footer widget (e.g., "Add new" button)
  final Widget? footer;

  /// Whether the dropdown is in loading state
  final bool isLoading;

  /// Widget to show when loading
  final Widget? loadingWidget;

  /// Widget to show when items list is empty
  final Widget? emptyWidget;

  /// Custom filter function for searching
  final bool Function(T item, String query)? customFilter;

  /// Whether to show search/filter functionality
  final bool enableSearch;

  /// Initial value to display
  final T? initialValue;

  /// Callback when dropdown opens
  final VoidCallback? onDropdownOpen;

  /// Callback when dropdown closes
  final VoidCallback? onDropdownClose;

  /// Custom decoration for the text field
  final InputDecoration? decoration;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Configuration for dropdown styling and behavior
  final DropxConfig config;

  const Dropx({
    super.key,
    required this.items,
    required this.focusNode,
    required this.onSelected,
    required this.hint,
    this.displayText,
    this.itemBuilder,
    this.header,
    this.footer,
    this.isLoading = false,
    this.loadingWidget,
    this.emptyWidget,
    this.customFilter,
    this.enableSearch = true,
    this.initialValue,
    this.onDropdownOpen,
    this.onDropdownClose,
    this.decoration,
    this.enabled = true,
    this.config = const DropxConfig(),
  });

  @override
  State<Dropx<T>> createState() => _DropxState<T>();
}

class _DropxState<T> extends State<Dropx<T>> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  late final LayerLink _layerLink;
  late DropxController<T> _controller;
  late DropxKeyboardHandler _keyboardHandler;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
    _layerLink = LayerLink();

    _controller = DropxController<T>(
      textController: _textController,
      scrollController: _scrollController,
      layerLink: _layerLink,
      allItems: widget.items,
      getDisplayText: _getDisplayText,
      customFilter: widget.customFilter,
      enableSearch: widget.enableSearch,
      minSearchLength: widget.config.minSearchLength,
    );

    _keyboardHandler = DropxKeyboardHandler(
      onArrowDown: _handleArrowDown,
      onArrowUp: _handleArrowUp,
      onEnter: _handleEnter,
      onEscape: _handleEscape,
      isDropdownOpen: () => _controller.isDropdownOpen,
    );

    widget.focusNode.addListener(_onFocusChange);

    // Set initial value if provided
    if (widget.initialValue != null) {
      _textController.text = _getDisplayText(widget.initialValue as T);
    }
  }

  @override
  void didUpdateWidget(Dropx<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update items if they changed
    if (oldWidget.items != widget.items) {
      _controller = DropxController<T>(
        textController: _textController,
        scrollController: _scrollController,
        layerLink: _layerLink,
        allItems: widget.items,
        getDisplayText: _getDisplayText,
        customFilter: widget.customFilter,
        enableSearch: widget.enableSearch,
        minSearchLength: widget.config.minSearchLength,
      );
      if (_controller.isDropdownOpen) {
        _updateOverlay();
      }
    }

    // Update initial value if changed
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != null) {
      _textController.text = _getDisplayText(widget.initialValue as T);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    widget.focusNode.removeListener(_onFocusChange);
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (!widget.enabled) return;

    if (widget.focusNode.hasFocus) {
      if (_textController.text.isEmpty || !widget.enableSearch) {
        _controller.updateFilteredItems(widget.items);
      }
      _showOverlay();
    } else {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!widget.focusNode.hasFocus) {
          _removeOverlay();
        }
      });
    }
  }

  String _getDisplayText(T item) {
    if (widget.displayText != null) {
      return widget.displayText!(item);
    }
    return item.toString();
  }

  void _filterItems(String query) {
    if (!widget.enableSearch) return;

    setState(() {
      _controller.filterItems(query);
    });

    if (_controller.filteredItems.isNotEmpty && widget.focusNode.hasFocus) {
      _showOverlay();
    } else if (_controller.filteredItems.isEmpty) {
      _updateOverlay();
    }
  }

  void _showOverlay() {
    if (_controller.overlayEntry != null) return;
    if (widget.isLoading) return;
    if (_controller.filteredItems.isEmpty && widget.emptyWidget == null) return;

    final overlayEntry = _createOverlayEntry();
    _controller.setOverlayEntry(overlayEntry);
    Overlay.of(context).insert(overlayEntry);
    setState(() {
      _controller.setDropdownOpen(true);
    });
    widget.onDropdownOpen?.call();
  }

  void _removeOverlay() {
    _controller.overlayEntry?.remove();
    _controller.setOverlayEntry(null);
    if (_controller.isDropdownOpen) {
      _controller.setDropdownOpen(false);
      widget.onDropdownClose?.call();
    }
  }

  void _selectItem(T item) {
    _textController.text = _getDisplayText(item);
    widget.onSelected(item);
    _removeOverlay();
  }

  void _updateOverlay() {
    _controller.overlayEntry?.markNeedsBuild();
    _scrollToSelected();
  }

  void _scrollToSelected() {
    _controller.scrollToSelected(
      widget.config.itemHeight,
      widget.config.scrollAnimationDuration,
      widget.config.scrollAnimationCurve,
    );
  }

  void _handleArrowDown() {
    if (!_controller.isDropdownOpen) {
      _showOverlay();
    } else {
      setState(() {
        _controller.moveSelectionDown();
      });
      _updateOverlay();
    }
  }

  void _handleArrowUp() {
    if (!_controller.isDropdownOpen) {
      _showOverlay();
    } else {
      setState(() {
        _controller.moveSelectionUp();
      });
      _updateOverlay();
    }
  }

  void _handleEnter() {
    final selectedItem = _controller.getSelectedItem();
    if (selectedItem != null) {
      _selectItem(selectedItem);
    }
  }

  void _handleEscape() {
    if (_controller.isDropdownOpen) {
      _removeOverlay();
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    final screenHeight = MediaQuery.of(context).size.height;
    final dropdownMaxHeight = widget.config.maxHeight ?? 300.0;
    final dropdownMinHeight = widget.config.minHeight ?? 150.0;
    final dropdownWidth = widget.config.width ?? size.width;

    final spaceBelow = screenHeight - offset.dy - size.height;
    final spaceAbove = offset.dy;

    final showAbove = spaceBelow < dropdownMaxHeight && spaceAbove > spaceBelow;
    final verticalOffset = showAbove
        ? -(dropdownMaxHeight + 2.0)
        : size.height + 2.0;

    return OverlayEntry(
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final style = widget.config.style;

        return Positioned(
          width: dropdownWidth,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, verticalOffset),
            child: Material(
              elevation: widget.config.elevation,
              shadowColor: style?.overlayShadowColor,
              borderRadius: widget.config.borderRadius,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: dropdownMinHeight,
                  maxHeight: showAbove
                      ? (spaceAbove - 10).clamp(
                          dropdownMinHeight,
                          dropdownMaxHeight,
                        )
                      : (spaceBelow - 10).clamp(
                          dropdownMinHeight,
                          dropdownMaxHeight,
                        ),
                ),
                decoration: BoxDecoration(
                  color: style?.overlayBackgroundColor ?? colorScheme.surface,
                  borderRadius: widget.config.borderRadius,
                  border: Border.all(
                    color:
                        style?.overlayBorderColor ??
                        colorScheme.outline.withOpacity(0.5),
                    width: style?.overlayBorderWidth ?? 1.0,
                  ),
                ),
                child: DropxOverlay<T>(
                  items: _controller.filteredItems,
                  selectedIndex: _controller.selectedIndex,
                  scrollController: _scrollController,
                  onItemSelected: _selectItem,
                  getDisplayText: _getDisplayText,
                  itemBuilder: widget.itemBuilder,
                  header: widget.header,
                  footer: widget.footer,
                  emptyWidget: widget.emptyWidget,
                  config: widget.config,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = widget.config.style;
    final textFieldBorderRadius =
        widget.config.textFieldBorderRadius ?? BorderRadius.circular(4);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        onKeyEvent: (node, event) {
          if (!widget.enabled) return KeyEventResult.ignored;
          return _keyboardHandler.handleKeyEvent(event);
        },
        child: TextField(
          controller: _textController,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          style:
              widget.config.textFieldTextStyle ??
              theme.textTheme.bodyMedium?.copyWith(
                color: style?.textFieldTextColor ?? colorScheme.onSurface,
              ),
          decoration:
              widget.decoration ??
              InputDecoration(
                hintText: widget.hint,
                hintStyle:
                    widget.config.hintTextStyle ??
                    theme.textTheme.bodyMedium?.copyWith(
                      color:
                          style?.textFieldHintColor ??
                          colorScheme.onSurface.withOpacity(0.6),
                    ),
                isDense: true,
                filled: style?.textFieldBackgroundColor != null,
                fillColor: style?.textFieldBackgroundColor,
                contentPadding:
                    widget.config.textFieldContentPadding ??
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                suffixIcon: widget.isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: widget.config.loadingIndicatorSize,
                          height: widget.config.loadingIndicatorSize,
                          child: CircularProgressIndicator(
                            strokeWidth:
                                widget.config.loadingIndicatorStrokeWidth,
                            color:
                                style?.loadingIndicatorColor ??
                                colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      )
                    : Icon(
                        _controller.isDropdownOpen
                            ? (widget.config.arrowIconOpen ??
                                  Icons.arrow_drop_up)
                            : (widget.config.arrowIconClosed ??
                                  Icons.arrow_drop_down),
                        size: widget.config.arrowIconSize,
                        color: widget.enabled
                            ? (_controller.isDropdownOpen
                                  ? (style?.arrowIconColorOpen ??
                                        style?.arrowIconColor ??
                                        colorScheme.onSurface)
                                  : (style?.arrowIconColor ??
                                        colorScheme.onSurface))
                            : (style?.arrowIconColorDisabled ??
                                  colorScheme.onSurface.withOpacity(0.38)),
                      ),
                border: widget.config.showTextFieldBorder
                    ? OutlineInputBorder(
                        borderRadius: textFieldBorderRadius,
                        borderSide: BorderSide(
                          color:
                              style?.textFieldBorderColor ??
                              colorScheme.outline,
                          width: widget.config.textFieldBorderWidth,
                        ),
                      )
                    : InputBorder.none,
                enabledBorder: widget.config.showTextFieldBorder
                    ? OutlineInputBorder(
                        borderRadius: textFieldBorderRadius,
                        borderSide: BorderSide(
                          color:
                              style?.textFieldBorderColor ??
                              colorScheme.outline,
                          width: widget.config.textFieldBorderWidth,
                        ),
                      )
                    : InputBorder.none,
                focusedBorder: widget.config.showTextFieldBorder
                    ? OutlineInputBorder(
                        borderRadius: textFieldBorderRadius,
                        borderSide: BorderSide(
                          color:
                              style?.textFieldFocusedBorderColor ??
                              colorScheme.primary,
                          width: widget.config.textFieldFocusedBorderWidth,
                        ),
                      )
                    : InputBorder.none,
                disabledBorder: widget.config.showTextFieldBorder
                    ? OutlineInputBorder(
                        borderRadius: textFieldBorderRadius,
                        borderSide: BorderSide(
                          color:
                              style?.textFieldDisabledBorderColor ??
                              colorScheme.onSurface.withOpacity(0.12),
                          width: widget.config.textFieldBorderWidth,
                        ),
                      )
                    : InputBorder.none,
              ),
          onChanged: widget.enableSearch ? _filterItems : null,
          readOnly: !widget.enableSearch,
        ),
      ),
    );
  }
}
