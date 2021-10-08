import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/AccountScreen.dart';
import 'package:vhelp_test/DiaryPreferences.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/splash_page.dart';

//void main() => runApp(MyRootApp());

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DiaryPreferences.init();
  runApp(MyRootApp());
}

class MyRootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ConnectivityProvider(), child: SplashScreen())
      ],
      child: MaterialApp(title: 'Flutter Demo', home: SplashScreen()),
    );
  }
}
