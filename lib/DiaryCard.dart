import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';

import 'DiarytDetail.dart';
import 'package:flutter/material.dart';

// This class is in buildPages()  -->  //1, //2, //3, ...
// ignore: must_be_immutable
class DiaryCard extends StatefulWidget {
  DiaryCard({
    Key? key,
    required this.day,
  }) : super(key: key);

  int day;

  @override
  _DiaryCardState createState() => _DiaryCardState();
}

class _DiaryCardState extends State<DiaryCard> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline) {
        return model.isOnline
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: new FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                            ),
                            Container(
                              child: Container(
                                child: DiaryDetail(
                                  day: widget.day,
                                ),
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              )
            : NoInternet();
      }
      return Container(
        child: Center(
         child: NoInternet(),
        ),
      );
    });
  }
}
