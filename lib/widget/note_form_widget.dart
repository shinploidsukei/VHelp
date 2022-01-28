import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteFormWidget extends StatefulWidget {
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  State<NoteFormWidget> createState() => _NoteFormWidgetState();
}

class _NoteFormWidgetState extends State<NoteFormWidget> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.title,
        style: TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: S.of(context)!.title,
          hintStyle: TextStyle(color: Colors.blueGrey.shade400),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? S.of(context)!.warningDiary1 : null,
        onChanged: widget.onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: widget.description,
        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: S.of(context)!.typeSth,
          hintStyle: TextStyle(color: Colors.blueGrey.shade400),
        ),
        validator: (title) => title != null && title.isEmpty
            ? S.of(context)!.warningDiary2
            : null,
        onChanged: widget.onChangedDescription,
      );
}
