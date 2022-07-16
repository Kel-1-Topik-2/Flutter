import 'package:shared_preferences/shared_preferences.dart';

class Token {
  String? _token;
  String get token => _token!;

  tokenFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
  }
}
