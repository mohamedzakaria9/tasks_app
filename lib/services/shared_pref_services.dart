
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/utiles/pref_keys.dart';

class SharedPrefServices {
  final SharedPreferences pref;

  SharedPrefServices(this.pref);

  Future<void> saveUser({
    required String token,
    required String name,
    required String email,
    required int id,
  }) async {
    pref.setString(PrefKeys.token, token);
    pref.setString(PrefKeys.name, name);
    pref.setString(PrefKeys.email, email);
    pref.setInt(PrefKeys.id, id);
  }

  Future<void> removeUser() async{
    pref.remove(PrefKeys.token);
    pref.remove(PrefKeys.name);
    pref.remove(PrefKeys.email);
    pref.remove(PrefKeys.id);
  }

  String? get token => pref.getString(PrefKeys.token);
  String? get email => pref.getString(PrefKeys.email);
  String? get name => pref.getString(PrefKeys.name);
  int? get id => pref.getInt(PrefKeys.id);
}
