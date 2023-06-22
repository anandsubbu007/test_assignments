import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption_app/config/route.dart';
import 'package:pet_adoption_app/provider/adoption.dart';
import 'package:pet_adoption_app/db/storage_manager.dart';
import 'package:pet_adoption_app/utils/theme/theme.dart';

/// Starting Poiint of App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  await AppStorageManager.instance.init();
  runApp(const PetApp());
}

class PetApp extends StatelessWidget {
  const PetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      /// Intalizing all Providers
      ChangeNotifierProvider(create: (_) => ThemeManager()),
      ChangeNotifierProvider(create: (_) => AdoptionProvider()),
    ], child: const PetAppInit());
  }
}
/// Root Widget of Application
class PetAppInit extends StatelessWidget {
  const PetAppInit({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(builder: (context, __, _) {
        final theme = Provider.of<ThemeManager>(context).getThemeMode();
        return MaterialApp(
          title: 'Pet Adoption',
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
