import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/work_page_controller.dart';
import 'package:renomateclient/pages/details_page.dart';
import 'package:renomateclient/theme.dart';

class WorkPage extends StatelessWidget {
  WorkPage({super.key});

  final WorkPageController controller = Get.put(WorkPageController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyTheme.accent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "My Work",
                  style: TextStyle(color: MyTheme.title, fontSize: 18),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.worklist.clear();
                  await controller.fetchDataFromFirestore();
                  // Add the following return statement
                  return Future<void>.value();
                },
                child: Obx(
                  () => ListView.builder(
                      itemCount: controller.worklist.length,
                      itemBuilder: (context, index) {
                        return myworkList(
                            context,
                            controller.worklist[index]['workID'],
                            controller.worklist[index]['isdone'],
                            controller.worklist[index]['workType'],
                            controller.worklist[index]['time'],
                            controller.worklist[index]['amount'],
                            height);
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myworkList(BuildContext context, String workID, bool isdone,
      String about, String time, String amount, double height) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: ElevatedButton(
        onPressed: () {
          Get.to(DetailsPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height * 0.02),
          ),
          padding: EdgeInsets.fromLTRB(
              height * 0.02, height * 0.02, height * 0.02, height * 0.02),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Work ID - $workID",
                      style: TextStyle(
                          color: MyTheme.text,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: height * 0.02,
                    ),
                    Text(
                      (isdone) ? "Done" : "In Process",
                      style: TextStyle(
                        color: (isdone) ? Colors.green : Colors.red,
                        fontSize: 17,
                      ),
                    ),
                    // const Expanded(
                    //   child: SizedBox(),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Get.to(DetailsPage());
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     // fixedSize: const Size(80, 15),
                    //     backgroundColor: MyTheme.button2,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(20)),
                    //   ),
                    //   child: Text(
                    //     "Details",
                    //     style: TextStyle(color: MyTheme.text, fontSize: 15),
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "About :- ",
                      style: TextStyle(
                        color: MyTheme.text,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      about,
                      style: TextStyle(
                        color: MyTheme.primary,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      "Time :- ",
                      style: TextStyle(
                        color: MyTheme.text,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: MyTheme.text,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      "Amount :- ",
                      style: TextStyle(
                        color: MyTheme.text,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      amount,
                      style: TextStyle(
                          color: MyTheme.text,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: MyTheme.text,
              size: 36,
            ),
          ],
        ),
      ),
    );
  }
}
