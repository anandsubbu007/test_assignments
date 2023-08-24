import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ap/config/route.dart';
import 'package:flutter_ap/infrastructure/local_service/storage_manager.dart';
import 'package:flutter_ap/utils/theme/theme.dart';

/// Starting Poiint of App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  await AppStorageManager.instance.init();
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      /// Intalizing all Providers
      ChangeNotifierProvider(create: (_) => ThemeManager()),
    ], child: const GameAppInit());
  }
}

/// Root Widget of Application
class GameAppInit extends StatelessWidget {
  const GameAppInit({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(builder: (context, __, _) {
        final theme = Provider.of<ThemeManager>(context).getThemeMode();
        return MaterialApp(
          title: 'Game Adoption',
          themeMode: theme,
          theme: ThemeManager.lightTheme(context),
          darkTheme: ThemeManager.darkTheme(context),
          initialRoute: Routes.homeRoute,
          routes: Routes.getRoute(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
