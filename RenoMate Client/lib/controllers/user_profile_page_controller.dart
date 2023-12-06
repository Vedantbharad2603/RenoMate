import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePageController extends GetxController {
  // String userName = "";
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String blockNo = "";
  String streetName = "";
  String city = "";
  String state = "";
  String pincode = "";

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
      blockNo = prefs.getString("blockNo") ?? "Block No";
      streetName = prefs.getString("streetName") ?? "Street Name";
      city = prefs.getString("city") ?? "City";
      state = prefs.getString("state") ?? "State";
      pincode = prefs.getString("pincode") ?? "Pincode";
    });
  }
}
