import 'package:shared_preferences/shared_preferences.dart';

//inisialisasi SharedPreferences
Future<void> saveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Menggunakan prefs untuk menyimpan data
} 
Future<void> saveStringData(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}