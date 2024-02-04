import 'package:shared_preferences/shared_preferences.dart';

writeStorage(String compID, String username) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('compId', compID);
  await prefs.setString('username', username);
}

clearStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
