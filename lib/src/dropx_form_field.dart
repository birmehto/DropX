import 'package:flutter/material.dart';

import 'dropx_config.dart';
import 'dropx_widget.dart';

/// A FormField wrapper for Dropx that provides validation support
class DropxFormField<T> extends FormField<T> {
  DropxFormField({
    super.key,
    required List<T> items,
    required String hint,
    String Function(T)? displayText,
    Widget Function(T, bool)? itemBuilder,
    Widget? header,
    Widget? footer,
    bool isLoading = false,
    Widget? loadingWidget,
    Widget? emptyWidget,
    bool Function(T, String)? customFilter,
    bool enableSearch = true,
    VoidCallback? onDropdownOpen,
    VoidCallback? onDropdownClose,
    InputDecoration? decoration,
    bool enabled = true,
    DropxConfig config = const DropxConfig(),
    bool showClearButton = false,
    ValueChanged<String>? onChanged,
    String? semanticLabel,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.autovalidateMode,
  }) : super(
          builder: (FormFieldState<T> field) {
            final _DropxFormFieldState<T> state =
                field as _DropxFormFieldState<T>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dropx<T>(
                  items: items,
                  focusNode: state._focusNode,
                  hint: hint,
                  displayText: displayText,
                  itemBuilder: itemBuilder,
                  header: header,
                  footer: footer,
                  isLoading: isLoading,
                  loadingWidget: loadingWidget,
                  emptyWidget: emptyWidget,
                  customFilter: customFilter,
                  enableSearch: enableSearch,
                  initialValue: field.value,
                  onDropdownOpen: onDropdownOpen,
                  onDropdownClose: onDropdownClose,
                  decoration: decoration?.copyWith(errorText: field.errorText),
                  enabled: enabled,
                  config: config,
                  showClearButton: showClearButton,
                  onClear: () {
                    field.didChange(null);
                  },
                  onChanged: onChanged,
                  semanticLabel: semanticLabel,
                  onSelected: (value) {
                    field.didChange(value);
                  },
                ),
                if (field.hasError && decoration == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: Text(
                      field.errorText!,
                      style: TextStyle(
                        color: Theme.of(field.context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );

  @override
  FormFieldState<T> createState() => _DropxFormFieldState<T>();
}

class _DropxFormFieldState<T> extends FormFieldState<T> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
