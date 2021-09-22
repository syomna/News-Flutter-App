import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

 static setBool({@required String key, @required bool value}) async {
   return await sharedPreferences.setBool(key, value);
  }

 static getBool(String key) => sharedPreferences.getBool(key);
}
