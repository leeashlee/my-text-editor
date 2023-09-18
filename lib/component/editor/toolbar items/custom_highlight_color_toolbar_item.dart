import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:noel_notes/custom_icon_item_widget.dart';
import 'package:flutter/material.dart';

ToolbarItem customBuildHighlightColorItem({List<ColorOption>? colorOptions}) {
  return ToolbarItem(
    id: 'editor.highlightColor',
    group: 4,
    isActive: onlyShowInTextType,
    builder: (context, editorState, highlightColor) {
      String? highlightColorHex;

      final selection = editorState.selection!;
      final nodes = editorState.getNodesInSelection(selection);
      final isHighlight = nodes.allSatisfyInSelection(selection, (delta) {
        return delta.everyAttributes((attributes) {
          highlightColorHex = attributes[AppFlowyRichTextKeys.highlightColor];
          return highlightColorHex != null;
        });
      });
      return CustomSVGIconItemWidget(
        iconName: 'toolbar/highlight_color',
        iconSize: const Size.square(14),
        isHighlight: isHighlight,
        highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
        normalColor: Theme.of(context).colorScheme.primary,
        tooltip: AppFlowyEditorLocalizations.current.highlightColor,
        onPressed: () {
          showColorMenu(
            context,
            editorState,
            selection,
            currentColorHex: highlightColorHex,
            isTextColor: false,
            highlightColorOptions: colorOptions,
          );
        },
      );
    },
  );
}