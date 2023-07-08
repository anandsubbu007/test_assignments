import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final instance = AppPreferences._();

  AppPreferences._();

  static const _fireUid = "fireUid";
  static const _fcmTokenKey = "fcm_token";
  static const _nextPageUrlKey = "next_page_url";
  static const _isLastPageKey = "is_last_page_key";
  static const _lastTime = "lastTime";

  late SharedPreferences _pref;

  Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  String? get notificationToken => _pref.getString(_fcmTokenKey);

  Future<void> setNotificationToken(String data) async {
    await _pref.setString(_fcmTokenKey, data);
  }

  String? get nextPageUrl {
    return _pref.getString(_nextPageUrlKey);
  }

  Future<void> setNextPageUrl(String data) async {
    await _pref.setString(_nextPageUrlKey, data);
  }

  bool get isLastPage {
    return _pref.getBool(_isLastPageKey) ?? false;
  }

  Future<void> setLastPage(bool isLastPage) async {
    await _pref.setBool(_isLastPageKey, isLastPage);
  }

  String? get userUid {
    return _pref.getString(_fireUid);
  }

  Future<void> setUID(String uid) async {
    await _pref.setString(_fireUid, uid);
  }

  Future<void> setLastPushMailTime(DateTime time) async {
    await _pref.setInt(_lastTime, time.millisecondsSinceEpoch);
  }

  DateTime get lastMailPushTime {
    final d = _pref.getInt(_lastTime);
    if (d != null) return DateTime.fromMillisecondsSinceEpoch(d);
    return DateTime.now().subtract(const Duration(days: 2));
  }
}
