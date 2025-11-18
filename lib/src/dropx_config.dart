import 'package:flutter/material.dart';

import 'dropx_style.dart';

/// Configuration class for Dropx styling and behavior
class DropxConfig {
  /// Border radius for dropdown and overlay
  final BorderRadius borderRadius;

  /// Border radius for text field
  final BorderRadius? textFieldBorderRadius;

  /// Elevation for the dropdown overlay
  final double elevation;

  /// Maximum height for the dropdown overlay
  final double? maxHeight;

  /// Minimum height for the dropdown overlay
  final double? minHeight;

  /// Custom width for the dropdown overlay
  final double? width;

  /// Padding for dropdown items
  final EdgeInsets itemPadding;

  /// Text style for dropdown items
  final TextStyle? itemTextStyle;

  /// Text style for selected dropdown items
  final TextStyle? selectedItemTextStyle;

  /// Text style for text field
  final TextStyle? textFieldTextStyle;

  /// Text style for hint text
  final TextStyle? hintTextStyle;

  /// Text style for empty state
  final TextStyle? emptyTextStyle;

  /// Minimum characters required before filtering
  final int minSearchLength;

  /// Debounce duration for search filtering (null = no debounce)
  final Duration? searchDebounce;

  /// Duration for scroll animation
  final Duration scrollAnimationDuration;

  /// Curve for scroll animation
  final Curve scrollAnimationCurve;

  /// Item height for scroll calculations
  final double itemHeight;

  /// Empty state icon size
  final double emptyIconSize;

  /// Loading indicator size
  final double loadingIndicatorSize;

  /// Loading indicator stroke width
  final double loadingIndicatorStrokeWidth;

  /// Arrow icon size
  final double arrowIconSize;

  /// Custom arrow icon when closed
  final IconData? arrowIconClosed;

  /// Custom arrow icon when open
  final IconData? arrowIconOpen;

  /// Show dividers between items
  final bool showItemDividers;

  /// Divider thickness
  final double dividerThickness;

  /// Divider indent
  final double dividerIndent;

  /// Divider end indent
  final double dividerEndIndent;

  /// Enable item hover effect
  final bool enableHoverEffect;

  /// Animation duration for dropdown open/close
  final Duration? animationDuration;

  /// Animation curve for dropdown open/close
  final Curve? animationCurve;

  /// Custom styling options
  final DropxStyle? style;

  /// Content padding for text field
  final EdgeInsets? textFieldContentPadding;

  /// Whether to show border on text field
  final bool showTextFieldBorder;

  /// Text field border width
  final double textFieldBorderWidth;

  /// Text field focused border width
  final double textFieldFocusedBorderWidth;

  const DropxConfig({
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.textFieldBorderRadius,
    this.elevation = 8.0,
    this.maxHeight,
    this.minHeight,
    this.width,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.itemTextStyle,
    this.selectedItemTextStyle,
    this.textFieldTextStyle,
    this.hintTextStyle,
    this.emptyTextStyle,
    this.minSearchLength = 0,
    this.searchDebounce,
    this.scrollAnimationDuration = const Duration(milliseconds: 200),
    this.scrollAnimationCurve = Curves.easeInOut,
    this.itemHeight = 50.0,
    this.emptyIconSize = 48.0,
    this.loadingIndicatorSize = 16.0,
    this.loadingIndicatorStrokeWidth = 2.0,
    this.arrowIconSize = 20.0,
    this.arrowIconClosed,
    this.arrowIconOpen,
    this.showItemDividers = false,
    this.dividerThickness = 1.0,
    this.dividerIndent = 0.0,
    this.dividerEndIndent = 0.0,
    this.enableHoverEffect = true,
    this.animationDuration,
    this.animationCurve,
    this.style,
    this.textFieldContentPadding,
    this.showTextFieldBorder = true,
    this.textFieldBorderWidth = 1.0,
    this.textFieldFocusedBorderWidth = 2.0,
  });

  DropxConfig copyWith({
    BorderRadius? borderRadius,
    BorderRadius? textFieldBorderRadius,
    double? elevation,
    double? maxHeight,
    double? minHeight,
    double? width,
    EdgeInsets? itemPadding,
    TextStyle? itemTextStyle,
    TextStyle? selectedItemTextStyle,
    TextStyle? textFieldTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? emptyTextStyle,
    int? minSearchLength,
    Duration? searchDebounce,
    Duration? scrollAnimationDuration,
    Curve? scrollAnimationCurve,
    double? itemHeight,
    double? emptyIconSize,
    double? loadingIndicatorSize,
    double? loadingIndicatorStrokeWidth,
    double? arrowIconSize,
    IconData? arrowIconClosed,
    IconData? arrowIconOpen,
    bool? showItemDividers,
    double? dividerThickness,
    double? dividerIndent,
    double? dividerEndIndent,
    bool? enableHoverEffect,
    Duration? animationDuration,
    Curve? animationCurve,
    DropxStyle? style,
    EdgeInsets? textFieldContentPadding,
    bool? showTextFieldBorder,
    double? textFieldBorderWidth,
    double? textFieldFocusedBorderWidth,
  }) {
    return DropxConfig(
      borderRadius: borderRadius ?? this.borderRadius,
      textFieldBorderRadius:
          textFieldBorderRadius ?? this.textFieldBorderRadius,
      elevation: elevation ?? this.elevation,
      maxHeight: maxHeight ?? this.maxHeight,
      minHeight: minHeight ?? this.minHeight,
      width: width ?? this.width,
      itemPadding: itemPadding ?? this.itemPadding,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      selectedItemTextStyle:
          selectedItemTextStyle ?? this.selectedItemTextStyle,
      textFieldTextStyle: textFieldTextStyle ?? this.textFieldTextStyle,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      minSearchLength: minSearchLength ?? this.minSearchLength,
      searchDebounce: searchDebounce ?? this.searchDebounce,
      scrollAnimationDuration:
          scrollAnimationDuration ?? this.scrollAnimationDuration,
      scrollAnimationCurve: scrollAnimationCurve ?? this.scrollAnimationCurve,
      itemHeight: itemHeight ?? this.itemHeight,
      emptyIconSize: emptyIconSize ?? this.emptyIconSize,
      loadingIndicatorSize: loadingIndicatorSize ?? this.loadingIndicatorSize,
      loadingIndicatorStrokeWidth:
          loadingIndicatorStrokeWidth ?? this.loadingIndicatorStrokeWidth,
      arrowIconSize: arrowIconSize ?? this.arrowIconSize,
      arrowIconClosed: arrowIconClosed ?? this.arrowIconClosed,
      arrowIconOpen: arrowIconOpen ?? this.arrowIconOpen,
      showItemDividers: showItemDividers ?? this.showItemDividers,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      dividerIndent: dividerIndent ?? this.dividerIndent,
      dividerEndIndent: dividerEndIndent ?? this.dividerEndIndent,
      enableHoverEffect: enableHoverEffect ?? this.enableHoverEffect,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      style: style ?? this.style,
      textFieldContentPadding:
          textFieldContentPadding ?? this.textFieldContentPadding,
      showTextFieldBorder: showTextFieldBorder ?? this.showTextFieldBorder,
      textFieldBorderWidth: textFieldBorderWidth ?? this.textFieldBorderWidth,
      textFieldFocusedBorderWidth:
          textFieldFocusedBorderWidth ?? this.textFieldFocusedBorderWidth,
    );
  }
}
