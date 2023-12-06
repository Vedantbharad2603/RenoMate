import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePageController extends GetxController {
  // String userName = "";
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SharedPreferences.getInstance().then((prefs) {
      phoneNumber = "+${prefs.getString("phoneNumber")!}";
      // userName =
      //     "${prefs.getString("firstName")} ${prefs.getString("lastName")}";
      firstName = prefs.getString("firstName")!;
      lastName = prefs.getString("lastName")!;
    });
  }
}
