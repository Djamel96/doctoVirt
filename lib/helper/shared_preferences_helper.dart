import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/main_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _isDoctor = '_isDoctor';
  static const String _me = 'me';
  static const String _token = 'token';

// clear the sharedPref
  static Future<bool> clearSharedPrefs(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return true;
  }

//the function that restore the user informations
  static Future restoreUserDataFromSheredPrefs(MainProvider mainStore) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isDoctor = prefs.getBool(_isDoctor);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  //the function that store the user data
  static Future<bool> storeUserDataInSheredPrefs(Doctor profile,
      {String? insti}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return true;
  }
}
