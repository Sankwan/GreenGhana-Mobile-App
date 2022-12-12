import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/provider/homepageprovider.dart';
import 'package:instagram_aa/provider/themeprovider.dart';
import 'package:instagram_aa/provider/userprovider.dart';
import 'package:instagram_aa/provider/videoprovider.dart';
import 'package:instagram_aa/theme/apptheme.dart';
import 'package:instagram_aa/views/screens/splashpage.dart';
import 'package:provider/provider.dart';

class Initialize extends StatelessWidget {
  const Initialize({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(builder: (_, mode, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ThemeProvider>(
                  create: (context) => ThemeProvider()),
              ChangeNotifierProvider<HomeProvider>(
                  create: (context) => HomeProvider()),
              ChangeNotifierProvider<UserProvider>(
                  create: (context) => UserProvider()),
              ChangeNotifierProvider<VideoProvider>(
                  create: (context) => VideoProvider()),
            ],
            child: MaterialApp(
              builder: BotToastInit(),
              debugShowCheckedModeBanner: false,
              theme: AppTheme().lightTheme,
              darkTheme: AppTheme().darkTheme,
              themeMode:
                  mode.darkTheme == true ? ThemeMode.dark : ThemeMode.light,
              home: const SplashPage(),
            ),
          );
        }));
  }
}
