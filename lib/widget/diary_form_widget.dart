import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/colorLog.dart';
import '../PopupDialog.dart';
import '../connectivity_provider.dart';
import '../no_internet.dart';

class DiaryFormWidget extends StatefulWidget {
  final colorLog? color;

  const DiaryFormWidget(
      {Key? key,
      required int colorIndex,
      this.color,
      required void Function(int) onChangedColorIndex})
      : super(key: key);

  @override
  _DiaryFormWidgetState createState() => _DiaryFormWidgetState();
}

class _DiaryFormWidgetState extends State<DiaryFormWidget> {
  int? selectedIndex;
  late int thisColor;
  String now = DateFormat("dd-MM-yyyy").format(DateTime.now());

  var emojiColors = [
    Colors.red[200],
    Colors.orange[200],
    Colors.yellow[200],
    Colors.green[200],
    Colors.green[400],
  ];

  @override
  void initState() {
    super.initState();
    // selectedIndex = (DiaryPreferences.getIndex() ?? '') as int?;
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Container(
                      //padding: const EdgeInsets.only(left: 1.0),
                      child: Container(
                          child: Text(
                        //${widget.day + 1}
                        "Today: $now",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ...List.generate(5, (index) => _buildEmoji(index)),
                        ],
                      )),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              : NoInternet();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildEmoji(int index) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.emoji_emotions),
        color: selectedIndex == index ? Colors.black : emojiColors[index],
        iconSize: 40.0,
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) => PopupDialog(
              selectedIndex: index,
              emojiColor: emojiColors[index]!,
            ),
          );
          setState(() {
            selectedIndex = index;
            thisColor = index;
            print(index);
            addOrUpdateColor(index);
            //addLogsToDB();
          });
          //await DiaryPreferences.setIndex(index);
          //SharedPreferences prefs = await SharedPreferences.getInstance();
          //final value = prefs.getInt('index');
          //print('value $value');
        },
      ),
    );
  }

  void addOrUpdateColor(int index) async {
    final isUpdating = widget.color != null;

    if (isUpdating) {
      await updateColor();
    } else {
      await addColor();
    }

    Navigator.of(context).pop();
  }

  Future updateColor() async {
    final color = widget.color!.copy(
      colorSaved: thisColor,
    );

    await LogsDatabase.instance.update(color);
  }

  Future addColor() async {
    final color = colorLog(
      colorSaved: thisColor,
      createTime: DateTime.now(),
    );

    await LogsDatabase.instance.create(color);
  }
}
