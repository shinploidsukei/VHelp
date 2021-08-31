import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedConfirmSuccess extends StatelessWidget {
  final String? payload;
  const MedConfirmSuccess({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
 Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Medicine Confirmation'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                payload ?? '',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Medicine Confirmation Success!',
                style: TextStyle(fontSize: 32),
              ),
            ],
          ),
        ),
      );
}
