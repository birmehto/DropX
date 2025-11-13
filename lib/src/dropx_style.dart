import 'package:flutter/material.dart';

/// Styling options for Dropx appearance
class DropxStyle {
  /// Background color for the dropdown overlay
  final Color? overlayBackgroundColor;

  /// Border color for the dropdown overlay
  final Color? overlayBorderColor;

  /// Border width for the dropdown overlay
  final double? overlayBorderWidth;

  /// Shadow color for the dropdown overlay
  final Color? overlayShadowColor;

  /// Background color for dropdown items
  final Color? itemBackgroundColor;

  /// Background color for selected item
  final Color? selectedItemBackgroundColor;

  /// Background color for hovered item
  final Color? hoveredItemBackgroundColor;

  /// Text color for dropdown items
  final Color? itemTextColor;

  /// Text color for selected item
  final Color? selectedItemTextColor;

  /// Icon color for dropdown arrow
  final Color? arrowIconColor;

  /// Icon color when dropdown is open
  final Color? arrowIconColorOpen;

  /// Icon color when dropdown is disabled
  final Color? arrowIconColorDisabled;

  /// Loading indicator color
  final Color? loadingIndicatorColor;

  /// Empty state icon color
  final Color? emptyIconColor;

  /// Empty state text color
  final Color? emptyTextColor;

  /// Text field border color
  final Color? textFieldBorderColor;

  /// Text field focused border color
  final Color? textFieldFocusedBorderColor;

  /// Text field disabled border color
  final Color? textFieldDisabledBorderColor;

  /// Text field background color
  final Color? textFieldBackgroundColor;

  /// Text field text color
  final Color? textFieldTextColor;

  /// Text field hint color
  final Color? textFieldHintColor;

  /// Header background color
  final Color? headerBackgroundColor;

  /// Header text color
  final Color? headerTextColor;

  /// Footer background color
  final Color? footerBackgroundColor;

  /// Footer text color
  final Color? footerTextColor;

  /// Divider color between items
  final Color? dividerColor;

  /// Ripple/splash color for item interactions
  final Color? splashColor;

  /// Highlight color for item interactions
  final Color? highlightColor;

  const DropxStyle({
    this.overlayBackgroundColor,
    this.overlayBorderColor,
    this.overlayBorderWidth,
    this.overlayShadowColor,
    this.itemBackgroundColor,
    this.selectedItemBackgroundColor,
    this.hoveredItemBackgroundColor,
    this.itemTextColor,
    this.selectedItemTextColor,
    this.arrowIconColor,
    this.arrowIconColorOpen,
    this.arrowIconColorDisabled,
    this.loadingIndicatorColor,
    this.emptyIconColor,
    this.emptyTextColor,
    this.textFieldBorderColor,
    this.textFieldFocusedBorderColor,
    this.textFieldDisabledBorderColor,
    this.textFieldBackgroundColor,
    this.textFieldTextColor,
    this.textFieldHintColor,
    this.headerBackgroundColor,
    this.headerTextColor,
    this.footerBackgroundColor,
    this.footerTextColor,
    this.dividerColor,
    this.splashColor,
    this.highlightColor,
  });

  /// Creates a copy with the given fields replaced with new values
  DropxStyle copyWith({
    Color? overlayBackgroundColor,
    Color? overlayBorderColor,
    double? overlayBorderWidth,
    Color? overlayShadowColor,
    Color? itemBackgroundColor,
    Color? selectedItemBackgroundColor,
    Color? hoveredItemBackgroundColor,
    Color? itemTextColor,
    Color? selectedItemTextColor,
    Color? arrowIconColor,
    Color? arrowIconColorOpen,
    Color? arrowIconColorDisabled,
    Color? loadingIndicatorColor,
    Color? emptyIconColor,
    Color? emptyTextColor,
    Color? textFieldBorderColor,
    Color? textFieldFocusedBorderColor,
    Color? textFieldDisabledBorderColor,
    Color? textFieldBackgroundColor,
    Color? textFieldTextColor,
    Color? textFieldHintColor,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    Color? footerBackgroundColor,
    Color? footerTextColor,
    Color? dividerColor,
    Color? splashColor,
    Color? highlightColor,
  }) {
    return DropxStyle(
      overlayBackgroundColor:
          overlayBackgroundColor ?? this.overlayBackgroundColor,
      overlayBorderColor: overlayBorderColor ?? this.overlayBorderColor,
      overlayBorderWidth: overlayBorderWidth ?? this.overlayBorderWidth,
      overlayShadowColor: overlayShadowColor ?? this.overlayShadowColor,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      selectedItemBackgroundColor:
          selectedItemBackgroundColor ?? this.selectedItemBackgroundColor,
      hoveredItemBackgroundColor:
          hoveredItemBackgroundColor ?? this.hoveredItemBackgroundColor,
      itemTextColor: itemTextColor ?? this.itemTextColor,
      selectedItemTextColor:
          selectedItemTextColor ?? this.selectedItemTextColor,
      arrowIconColor: arrowIconColor ?? this.arrowIconColor,
      arrowIconColorOpen: arrowIconColorOpen ?? this.arrowIconColorOpen,
      arrowIconColorDisabled:
          arrowIconColorDisabled ?? this.arrowIconColorDisabled,
      loadingIndicatorColor:
          loadingIndicatorColor ?? this.loadingIndicatorColor,
      emptyIconColor: emptyIconColor ?? this.emptyIconColor,
      emptyTextColor: emptyTextColor ?? this.emptyTextColor,
      textFieldBorderColor: textFieldBorderColor ?? this.textFieldBorderColor,
      textFieldFocusedBorderColor:
          textFieldFocusedBorderColor ?? this.textFieldFocusedBorderColor,
      textFieldDisabledBorderColor:
          textFieldDisabledBorderColor ?? this.textFieldDisabledBorderColor,
      textFieldBackgroundColor:
          textFieldBackgroundColor ?? this.textFieldBackgroundColor,
      textFieldTextColor: textFieldTextColor ?? this.textFieldTextColor,
      textFieldHintColor: textFieldHintColor ?? this.textFieldHintColor,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      footerBackgroundColor:
          footerBackgroundColor ?? this.footerBackgroundColor,
      footerTextColor: footerTextColor ?? this.footerTextColor,
      dividerColor: dividerColor ?? this.dividerColor,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  /// Merges this style with another, with the other taking precedence
  DropxStyle merge(DropxStyle? other) {
    if (other == null) return this;
    return copyWith(
      overlayBackgroundColor: other.overlayBackgroundColor,
      overlayBorderColor: other.overlayBorderColor,
      overlayBorderWidth: other.overlayBorderWidth,
      overlayShadowColor: other.overlayShadowColor,
      itemBackgroundColor: other.itemBackgroundColor,
      selectedItemBackgroundColor: other.selectedItemBackgroundColor,
      hoveredItemBackgroundColor: other.hoveredItemBackgroundColor,
      itemTextColor: other.itemTextColor,
      selectedItemTextColor: other.selectedItemTextColor,
      arrowIconColor: other.arrowIconColor,
      arrowIconColorOpen: other.arrowIconColorOpen,
      arrowIconColorDisabled: other.arrowIconColorDisabled,
      loadingIndicatorColor: other.loadingIndicatorColor,
      emptyIconColor: other.emptyIconColor,
      emptyTextColor: other.emptyTextColor,
      textFieldBorderColor: other.textFieldBorderColor,
      textFieldFocusedBorderColor: other.textFieldFocusedBorderColor,
      textFieldDisabledBorderColor: other.textFieldDisabledBorderColor,
      textFieldBackgroundColor: other.textFieldBackgroundColor,
      textFieldTextColor: other.textFieldTextColor,
      textFieldHintColor: other.textFieldHintColor,
      headerBackgroundColor: other.headerBackgroundColor,
      headerTextColor: other.headerTextColor,
      footerBackgroundColor: other.footerBackgroundColor,
      footerTextColor: other.footerTextColor,
      dividerColor: other.dividerColor,
      splashColor: other.splashColor,
      highlightColor: other.highlightColor,
    );
  }
}
