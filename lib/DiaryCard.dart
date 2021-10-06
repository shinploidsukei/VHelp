import 'DiarytDetail.dart';
import 'package:flutter/material.dart';

// This class is in buildPages()  -->  //1, //2, //3, ...
class DiaryCard extends StatefulWidget {
  const DiaryCard({
    Key? key,
    required this.day,
  }) : super(key: key);

  final int day;

  @override
  _DiaryCardState createState() => _DiaryCardState();
}

class _DiaryCardState extends State<DiaryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    height: 80,
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
    );
  }
}
