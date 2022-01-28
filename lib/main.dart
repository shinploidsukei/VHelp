import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/DiaryPreferences.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/db/db_helper.dart';
import 'package:vhelp_test/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vhelp_test/provider/locale_provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:vhelp_test/widget/sound_picker_widget.dart';

//void main() => runApp(MyRootApp());

void main() async {
  AwesomeNotifications().initialize(
    '@mipmap/ic_launcher',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.blue[300],
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DiaryPreferences.init();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyRootApp());
}

class MyRootApp extends StatefulWidget {
  MainRootState createState() => MainRootState();
}

// This widget is the root of your application.
class MainRootState extends State<MyRootApp> {
  late SoundPickerWidget _assetsAudioPlayer = new SoundPickerWidget();

  @override
  void initState() {
    super.initState();
    // _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.LoopAudio();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          //child: SplashScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final provider = Provider.of<LocaleProvider>(context);
            // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
            //     overlays: [SystemUiOverlay.top]);
            //SystemChrome.setEnabledSystemUIOverlays([]);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: provider.locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.supportedLocales,
              home: SplashScreen(),
              navigatorKey: Get.key,
            );
          },
        ),
      ],
    );
  }
}
