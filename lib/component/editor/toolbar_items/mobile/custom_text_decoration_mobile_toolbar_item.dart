import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:noel_notes/component/icons/unicon_icons.dart';

final customTextDecorationMobileToolbarItem = MobileToolbarItem.withMenu(
  itemIcon: const Icon(Unicon.text),
  itemMenuBuilder: (editorState, selection, _) {
    return _TextDecorationMenu(editorState, selection);
  },
);

class _TextDecorationMenu extends StatefulWidget {
  const _TextDecorationMenu(
    this.editorState,
    this.selection, {
    Key? key,
  }) : super(key: key);

  final EditorState editorState;
  final Selection selection;

  @override
  State<_TextDecorationMenu> createState() => _TextDecorationMenuState();
}

class _TextDecorationMenuState extends State<_TextDecorationMenu> {
  final textDecorations = [
    TextDecorationUnit(
      icon: const Icon(Unicon.bold),
      label: AppFlowyEditorLocalizations.current.bold,
      name: AppFlowyRichTextKeys.bold,
    ),
    TextDecorationUnit(
      icon: const Icon(Unicon.italic),
      label: AppFlowyEditorLocalizations.current.italic,
      name: AppFlowyRichTextKeys.italic,
    ),
    TextDecorationUnit(
      icon: const Icon(Unicon.underline),
      label: AppFlowyEditorLocalizations.current.underline,
      name: AppFlowyRichTextKeys.underline,
    ),
    TextDecorationUnit(
      icon: const Icon(Unicon.text_strike_through),
      label: AppFlowyEditorLocalizations.current.strikethrough,
      name: AppFlowyRichTextKeys.strikethrough,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final style = MobileToolbarStyle.of(context);
    final btnList = textDecorations.map((currentDecoration) {
      // Check current decoration is active or not
      final nodes = widget.editorState.getNodesInSelection(widget.selection);
      final isSelected = nodes.allSatisfyInSelection(widget.selection, (delta) {
        return delta.everyAttributes(
          (attributes) => attributes[currentDecoration.name] == true,
        );
      });

      return MobileToolbarItemMenuBtn(
        icon: currentDecoration.icon,
        label: Text(currentDecoration.label),
        isSelected: isSelected,
        onPressed: () {
          if (widget.selection.isCollapsed) {
            // TODO(yijing): handle collapsed selection
          } else {
            setState(() {
              widget.editorState.toggleAttribute(currentDecoration.name);
            });
          }
        },
      );
    }).toList();

    return GridView(
      shrinkWrap: true,
      gridDelegate: buildMobileToolbarMenuGridDelegate(
        mobileToolbarStyle: style,
        crossAxisCount: 2,
      ),
      children: btnList,
    );
  }
}

class TextDecorationUnit {
  final Icon icon;
  final String label;
  final String name;

  TextDecorationUnit({
    required this.icon,
    required this.label,
    required this.name,
  });
}
