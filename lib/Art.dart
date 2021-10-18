import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/api/firebase_api.dart';
import 'package:vhelp_test/widget/art_widget.dart';

class ArtTherapy extends StatelessWidget {
  static final String title = 'Art Therapy';
  Future artSync() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.green),
        home: ArtTherapyPage(),
      );
}

class ArtTherapyPage extends StatefulWidget {
  @override
  _ArtTherapyPageState createState() => _ArtTherapyPageState();
}

class _ArtTherapyPageState extends State<ArtTherapyPage> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: Text(ArtTherapy.title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    final url =
                        'https://artsandculture.google.com/project/exhibits';
                    VisitExhibition(url: url, inApp: true);
                  },
                  child: Text("Visit Art and Culture Exhibition")),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    final url = 'https://nmwa.org/whats-on/exhibitions/online/';
                    VisitExhibition(url: url, inApp: true);
                  },
                  child: Text("Visit National Museum of Women in the Arts")),
            ],
          ),
        ),
      ),
    );
  }

  Future VisitExhibition({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false, forceWebView: true, enableJavaScript: true);
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
