import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/DiaryPreferences.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/splash_page.dart';

//void main() => runApp(MyRootApp());

void main() async {
  AwesomeNotifications().initialize(
    '@mipmap/ic_launcher',
    [NotificationChannel(channelKey: 'basic_channel',channelName: 'Basic Notifications',
    defaultColor: Colors.blue[300],
    importance: NotificationImportance.High,
    channelShowBadge: true,
    )],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DiaryPreferences.init();
  runApp(MyRootApp());
}

class MyRootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ConnectivityProvider(), child: SplashScreen())
      ],
      child: MaterialApp(title: 'Flutter Demo', home: SplashScreen()),
    );
  }
}
