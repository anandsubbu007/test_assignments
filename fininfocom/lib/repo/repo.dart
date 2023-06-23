import 'package:dio/dio.dart';
import 'package:fininfocom/model/profile_res.dart';

class AppRepo {
  AppRepo();

  static Future<String> fetchImage() async {
    var url = "https://dog.ceo/api/breeds/image/random";
    Response response = await Dio().get(url);
    return response.data['message'].toString();
  }

 static Future<ProfileRes> getProfileData() async {
    var url = "https://randomuser.me/api/";
    Response response = await Dio().get(url);
    final data = ProfileRes.fromJson(response.data);
    return data;
  }
}
