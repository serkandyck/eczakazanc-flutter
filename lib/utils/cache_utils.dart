import 'package:shared_preferences/shared_preferences.dart';

getCache(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString(key);
}


setCache(String key,value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(key, (value != null && value.length > 0) ? value : "");
}

setDuration(String key, value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setInt(key, value);
}

getDuration(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt(key);
}

clearCache(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString(key, null);
}

