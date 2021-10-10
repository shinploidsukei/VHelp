import 'package:flutter/material.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/widget/diary_form_widget.dart';

class AddEditMoodPage extends StatefulWidget {
  final colorLog? color;

  const AddEditMoodPage({
    Key? key,
    this.color,
  }) : super(key: key);
  @override
  _AddEditMoodPageState createState() => _AddEditMoodPageState();
}

class _AddEditMoodPageState extends State<AddEditMoodPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;

  late int colorIndex;

  @override
  void initState() {
    super.initState();

    // --Ask later--
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
              child: DiaryFormWidget(
                colorIndex: colorIndex,
                onChangedColorIndex: (colorIndex) =>
                    setState(() => this.colorIndex = colorIndex),
              ),
            ),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = colorIndex.isNegative;

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
