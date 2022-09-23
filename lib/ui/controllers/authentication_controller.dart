import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/use_case/authentication.dart';
import 'package:f_shared_prefs_template/ui/pages/authentication/login_page.dart';

class AuthenticationController extends GetxController {
  var _logged = false.obs;
  final Authentication _authentication = Get.find<Authentication>();

  bool get logged => _logged.value;

  set logged(bool mode) {
    _logged.value = mode;
  }

  void initializeRoute() async {
    logged = await _authentication.init;
  }

  AuthenticationController() {
    initializeRoute();
  }

  // para cada uno llamar los métodos del use_case authentication

  Future<bool> login(user, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') == user &&
        prefs.getString('password') == password) {
      prefs.setBool('logged', true);
      return true;
    }
    return false;
  }

  Future<bool> signup(user, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
    prefs.setString('password', password);
    return true;
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.to(() => const LoginPage());
    prefs.setBool('logged', false);
  }
}
