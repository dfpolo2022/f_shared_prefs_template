import '../../data/repositories/local_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final _sharedPreferences = LocalPreferences();

  //ejemplo para almacenar un string
  // await_sharedPreferences.storeData<String>('user', user);

  // aquí hay un ejemplo de cómo leer un bool
  Future<bool> get init async =>
      await _sharedPreferences.retrieveData<bool>('logged') ?? false;

  Future<bool> login(user, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') == user &&
        prefs.getString('password') == password) {
      await _sharedPreferences.storeData('logged', true);
      prefs.setBool('logged', true);
      return true;
    }
    return false;
    // verificar si user y password coinciden con los almacenados
    // en ese caso cambiar el estado de loggeed y devolver  Future.value(true);
  }

  Future<void> signup(user, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _sharedPreferences.storeData('user', user);
    prefs.setString('user', user);
    await _sharedPreferences.storeData('password', password);
    prefs.setString('password', password);
    // almancenar user y password
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _sharedPreferences.storeData('logged', false);
    prefs.setBool('logged', false);
    // cambiar loggeed
  }
}
