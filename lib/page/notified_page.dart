import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          this.label.toString().split("|")[0],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                scale: 5,
                image: AssetImage('assets/images/cut.png'),
                alignment: Alignment.bottomCenter),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: Text(
                this.label.toString().split("|")[1],
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
