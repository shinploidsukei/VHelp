import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/DiaryPreferences.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/splash_page.dart';
import 'package:vhelp_test/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vhelp_test/provider/locale_provider.dart';

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
  runApp(MyRootApp());
}

class MyRootApp extends StatelessWidget {
  // This widget is the root of your application.
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
                home: SplashScreen());
          },
        ),
      ],
      /*child: MaterialApp(title: 'Flutter Demo',
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: SplashScreen()),*/
    );
  }
}
