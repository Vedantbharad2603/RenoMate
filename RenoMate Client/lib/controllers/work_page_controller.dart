import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkPageController extends GetxController {
  // var worklist = <Map<String, dynamic>>[
  //   {
  //     "workID": "Work ID - 69",
  //     "isdone": false,
  //     "about": "Full Renovation",
  //     "time": "23/9/23--23/10/23",
  //     "amount": "2,00,000",
  //   },
  //   {
  //     "workID": "Work ID - 67",
  //     "isdone": true,
  //     "about": "Wall Painting",
  //     "time": "11/9/23--16/8/23",
  //     "amount": "40,000",
  //   },
  //   {
  //     "workID": "Work ID - 69",
  //     "isdone": false,
  //     "about": "Full Renovation",
  //     "time": "23/9/23--23/10/23",
  //     "amount": "2,00,000",
  //   },
  //   {
  //     "workID": "Work ID - 69",
  //     "isdone": false,
  //     "about": "Full Renovation",
  //     "time": "23/9/23--23/10/23",
  //     "amount": "2,00,000",
  //   },
  //   {
  //     "workID": "Work ID - 69",
  //     "isdone": false,
  //     "about": "Full Renovation",
  //     "time": "23/9/23--23/10/23",
  //     "amount": "2,00,000",
  //   },
  //   {
  //     "workID": "Work ID - 69",
  //     "isdone": false,
  //     "about": "Full Renovation",
  //     "time": "23/9/23--23/10/23",
  //     "amount": "2,00,000",
  //   },
  //   {
  //     "workID": "Work ID - 69",
  //     "isdone": false,
  //     "about": "Full Renovation",
  //     "time": "23/9/23--23/10/23",
  //     "amount": "2,00,000",
  //   },
  //   {
  //     "workID": "Work ID - 69",
  //     "isdone": false,
  //     "about": "Full Renovation",
  //     "time": "23/9/23--23/10/23",
  //     "amount": "2,00,000",
  //   },
  // ].obs;

  var worklist = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataFromFirestore();
  }

  fetchDataFromFirestore() async {
    await SharedPreferences.getInstance().then((prefs) {
      print("hii meet");
      CollectionReference userWork = FirebaseFirestore.instance
          .collection('client/${prefs.getString("phoneNumber")}/mywork');

      // QuerySnapshot<Object?> querySnapshot = await userWork.get();

      userWork
          .get()
          .then((querySnapshot) => querySnapshot.docs.forEach((element) {
                // print(element.data());
                worklist.add({
                  "workID": element.get("workID"),
                  "isdone": element.get("isdone"),
                  "workType": element.get("workType"),
                  "time": element.get("time"),
                  "amount": element.get("amount"),
                });
              }));

      // worklist.assignAll(querySnapshot.docs.map((doc) => doc.data()).toList());
    });
  }
}
