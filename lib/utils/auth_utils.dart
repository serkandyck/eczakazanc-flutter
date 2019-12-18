import 'package:shared_preferences/shared_preferences.dart';

isLoggedIn() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var data = preferences.getString('jwt-token');
  if (data != null && data.length > 0) {
      return true;
    }
    return false;
}
