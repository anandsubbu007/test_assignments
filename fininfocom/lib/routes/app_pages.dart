import 'package:fininfocom/presentaion/profile_pg.dart';
import 'package:flutter/cupertino.dart';
import '../presentaion/random_image_pg.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.randomImageScreen: (context) => const RandomImagePg(),
      AppRoutes.profileScreen: (context) => const ProfilePg(),
    };
  }
}
