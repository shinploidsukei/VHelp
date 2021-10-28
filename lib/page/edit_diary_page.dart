import 'package:flutter/material.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/page/diary_page.dart';
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
    colorIndex = widget.color?.colorSaved ?? 0;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiaryPage()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Colors.blue.shade100,
          elevation: 0,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                Form(key: _formKey, child: checkIf(widget.color?.createTime)),
          ),
        ),
      );

  Widget checkIf(DateTime? today) {
    return DiaryFormWidget(
      color: widget.color,
      colorIndex: colorIndex,
      onChangedColorIndex: (colorIndex) =>
          setState(() => this.colorIndex = colorIndex),
    );
  }
}
