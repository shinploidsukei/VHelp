import 'package:flutter/material.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/colorLog.dart';
import '../model/note.dart';
import '../widget/note_form_widget.dart';

class AddEditMoodPage extends StatefulWidget {
  final Note? note;
  final colorLog? color;

  const AddEditMoodPage({
    Key? key,
    this.color,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditMoodPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  late int colorIndex;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    colorIndex = widget.color?.colorSaved ?? 0;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          actions: [buildButton()],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: NoteFormWidget(
                isImportant: isImportant,
                number: number,
                title: title,
                description: description,
                onChangedImportant: (isImportant) =>
                    setState(() => this.isImportant = isImportant),
                onChangedNumber: (number) =>
                    setState(() => this.number = number),
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),

              ),
            ),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? Colors.blueGrey : Colors.blueGrey[200],
        ),
        onPressed: addOrUpdateColor,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateColor() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.color != null;

      if (isUpdating) {
        await updateColor();
      } else {
        await addColor();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateColor() async {
    final color = widget.color!.copy(
      colorSaved: colorIndex,
    );

    await LogsDatabase.instance.update(color);
  }

  Future addColor() async {
    final color = colorLog(
      colorSaved: colorIndex,
      createTime: DateTime.now(),
    );

    await LogsDatabase.instance.create(color);
  }
}
