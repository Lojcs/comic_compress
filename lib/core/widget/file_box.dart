import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import '../extensions/context_extension.dart';
import '../state/mubit.dart';
import 'custom_box.dart';
import 'custom_button.dart';
import 'recursive_mubit_widget.dart';

class FileBox<C extends Mubit<T>, T> extends SelectingWidget<C, T, Directory?> {
  final String title;
  final bool large;
  const new({
    super.key,
    required super.selector,
    required super.valueChanged,
    required this.title,
    this.large = false,
  });

  void onFile(Uri uri) => valueChanged(Directory.fromUri(uri));

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    bool hovering = false;
    return StatefulBuilder(
      builder: (context, setState) => CustomBox(
        type: hovering ? .selected : .normal,
        dense: !large,
        child: DropRegion(
          hitTestBehavior: .opaque,
          formats: [Formats.fileUri],
          onDropEnter: (_) => setState(() => hovering = true),
          onDropLeave: (_) => setState(() => hovering = false),
          onDropOver: (event) async {
            setState(() => hovering = true);
            if (event.session.allowedOperations.contains(DropOperation.link)) {
              return .link;
            } else if (event.session.allowedOperations.contains(
              DropOperation.copy,
            )) {
              return .copy;
            } else if (event.session.allowedOperations.contains(
              DropOperation.move,
            )) {
              return .move;
            } else {
              return .none;
            }
          },
          onPerformDrop: (event) async {
            final item = event.session.items.first;
            item.dataReader!.getValue(Formats.fileUri, (uri) {
              if (uri == null) return;
              onFile(uri);
            });
          },
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              SizedBox(
                height: 32,
                child: Text(title, style: textTheme.titleMedium),
              ),
              BlocSelector<C, T, Directory?>(
                selector: selector,
                builder: (context, state) => LayoutBuilder(
                  builder: (context, constraints) => Flex(
                    direction: large ? .vertical : .horizontal,
                    mainAxisAlignment: .spaceBetween,
                    spacing: 12,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth - 200,
                        ),
                        child: Align(
                          alignment: large ? .center : .centerLeft,
                          child: state == null
                              ? Text("No folder selected.")
                              : Text(path.basename(state.path)),
                        ),
                      ),
                      Center(
                        child: _DirectoryPickInstructions(
                          title: title,
                          onFile: onFile,
                          state: state,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DirectoryPickInstructions extends StatelessWidget {
  final String title;
  final Directory? state;
  final void Function(Uri uri) onFile;
  const new({
    super.key,
    required this.title,
    required this.state,
    required this.onFile,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      mainAxisSize: .min,
      children: [
        Text("Drag and drop or", style: textTheme.labelMedium),
        Padding(
          padding: .symmetric(horizontal: 4),
          child: CustomButton(
            text: "pick folder",
            onTap: () async {
              final path = await FilePicker.getDirectoryPath(
                dialogTitle: "Pick $title",
                initialDirectory: state?.path,
              );
              if (path != null && context.mounted) {
                onFile(Uri.file(path));
              }
            },
            textStyle: textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
