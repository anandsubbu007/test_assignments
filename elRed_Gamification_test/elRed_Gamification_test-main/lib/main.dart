import 'package:flutter/material.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';
import 'package:flutter_app/utils/extensions/context_ext.dart';
import 'package:flutter_app/view_model/provider/home_page_control.dart';
import 'package:flutter_app/view/home/home_pg.dart';
import 'package:flutter_app/view_model/service/screen_repo.dart';
import 'package:google_fonts/google_fonts.dart';
export 'utils/extensions/context_ext.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repo>(
          create: (context) => Repo(http.Client()),
        ),
        ChangeNotifierProvider(
          create: (context) => HomePageControl(context.read<Repo>()),
        )
      ],
      child: MaterialApp(
        title: 'Gamification',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.focused),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(context.textTheme),
        ),
        home: const HomePg(),
      ),
    );
  }
}
