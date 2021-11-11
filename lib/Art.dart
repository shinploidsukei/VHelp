import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArtTherapyPage extends StatefulWidget {
  @override
  _ArtTherapyPageState createState() => _ArtTherapyPageState();
}

class _ArtTherapyPageState extends State<ArtTherapyPage> {
  UploadTask? task;

  File? fileImage;
  final List<String> imgShow = [
    'assets/images/artCulture.png',
    'assets/images/knd.png'
  ];

  Future artSync() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    // final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? Scaffold(
                  backgroundColor: Colors.blue.shade100,
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    iconTheme: IconThemeData(color: Colors.black54),
                    backgroundColor: Colors.blue.shade100,
                    elevation: 0,
                    actions: [
                      LanguagePickerWidget(),
                      //const SizedBox(width: 12),
                    ],
                    title: Text(S.of(context)!.sidebar6,
                        style: TextStyle(color: Colors.black54, fontSize: 22)),
                  ),
                  body: Container(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/artCulture.png',
                              fit: BoxFit.fitWidth,
                            ),
                            FloatingActionButton(
                              child: Icon(Icons.arrow_upward_rounded),
                              onPressed: () async {
                                final url =
                                    'https://artsandculture.google.com/project/exhibits';
                                VisitExhibition(url: url, inApp: true);
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/NMWA.png',
                              fit: BoxFit.fitWidth,
                            ),
                            FloatingActionButton(
                              child: Icon(Icons.arrow_upward_rounded),
                              onPressed: () async {
                                final url =
                                    'https://nmwa.org/whats-on/exhibitions/online/';
                                VisitExhibition(url: url, inApp: true);
                              },
                            )
                          ],
                        ),
                      ],
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
      },
    );
  }
}

// ignore: non_constant_identifier_names
Future VisitExhibition({
  required String url,
  bool inApp = false,
}) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceSafariVC: false, forceWebView: true, enableJavaScript: true);
  }
}
 



  /* Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }*/

  /*Future uploadFile() async {
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
*/
  /* Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
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
      );*/

