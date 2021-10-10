import 'package:shared_preferences/shared_preferences.dart';

class DiaryPreferences {
  static SharedPreferences? _preferences;

  static const _keyIndex = 'index';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setIndex(int index) async =>
  await _preferences!.setInt(_keyIndex, index);

  static int? getIndex() => _preferences!.getInt(_keyIndex);

}
