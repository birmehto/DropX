import 'package:flutter/material.dart';
import 'dropx_config.dart';

/// Builds the Dropx overlay content
class DropxOverlay<T> extends StatelessWidget {
  final List<T> items;
  final int selectedIndex;
  final ScrollController scrollController;
  final Function(T) onItemSelected;
  final String Function(T) getDisplayText;
  final Widget Function(T, bool)? itemBuilder;
  final Widget? header;
  final Widget? footer;
  final Widget? emptyWidget;
  final DropxConfig config;

  const DropxOverlay({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.scrollController,
    required this.onItemSelected,
    required this.getDisplayText,
    this.itemBuilder,
    this.header,
    this.footer,
    this.emptyWidget,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = config.style;

    // Show empty state
    if (items.isEmpty) {
      return emptyWidget ?? _buildDefaultEmptyWidget(context);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) header!,
        Flexible(
          child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (context, index) {
              if (!config.showItemDividers) return const SizedBox.shrink();
              return Divider(
                height: config.dividerThickness,
                thickness: config.dividerThickness,
                indent: config.dividerIndent,
                endIndent: config.dividerEndIndent,
                color:
                    style?.dividerColor ?? colorScheme.outline.withOpacity(0.2),
              );
            },
            itemBuilder: (context, index) {
              final item = items[index];
              final isSelected = index == selectedIndex;

              if (itemBuilder != null) {
                return InkWell(
                  onTap: () => onItemSelected(item),
                  splashColor: style?.splashColor,
                  highlightColor: style?.highlightColor,
                  child: itemBuilder!(item, isSelected),
                );
              }

              // Default item using theme or custom colors
              return InkWell(
                onTap: () => onItemSelected(item),
                splashColor: style?.splashColor,
                highlightColor: style?.highlightColor,
                hoverColor: config.enableHoverEffect
                    ? (style?.hoveredItemBackgroundColor ??
                          colorScheme.primaryContainer.withOpacity(0.5))
                    : null,
                child: Container(
                  padding: config.itemPadding,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (style?.selectedItemBackgroundColor ??
                              colorScheme.primaryContainer)
                        : (style?.itemBackgroundColor ?? colorScheme.surface),
                  ),
                  child: Text(
                    getDisplayText(item),
                    style: isSelected
                        ? (config.selectedItemTextStyle ??
                              theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    style?.selectedItemTextColor ??
                                    colorScheme.onPrimaryContainer,
                              ))
                        : (config.itemTextStyle ??
                              theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    style?.itemTextColor ??
                                    colorScheme.onSurface,
                              )),
                  ),
                ),
              );
            },
          ),
        ),
        if (footer != null) footer!,
      ],
    );
  }

  Widget _buildDefaultEmptyWidget(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = config.style;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: config.emptyIconSize,
            color:
                style?.emptyIconColor ??
                colorScheme.onSurface.withOpacity(0.38),
          ),
          const SizedBox(height: 8),
          Text(
            'No items found',
            style:
                config.emptyTextStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  color:
                      style?.emptyTextColor ??
                      colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }
}
