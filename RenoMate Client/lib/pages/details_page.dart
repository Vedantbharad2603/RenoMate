import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/details_page_controller.dart';
import 'package:renomateclient/theme.dart';
import 'package:renomateclient/utils/my_timeline_tile.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});

  final DetailsPageController controller = Get.put(DetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          // "RenoMate",
          "R E N O M A T E",
          style: TextStyle(
            // fontSize: 30,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: MyTheme.accent,
        surfaceTintColor: MyTheme.accent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            MyTimeLineTile(
                isFirst: true,
                isLast: false,
                isPast: true,
                eventCard: Column(
                  children: [
                    Text(
                      "Worker Found",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: true ? MyTheme.background : MyTheme.text),
                    ),
                    Text(
                      "Workername will come to your place soon",
                      style: TextStyle(
                          fontSize: 15,
                          color:
                              true ? MyTheme.background : Colors.transparent),
                    ),
                  ],
                )),
            MyTimeLineTile(
                isFirst: false,
                isLast: false,
                isPast: true,
                eventCard: Column(
                  children: [
                    Text(
                      "Measurements Taken",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: true ? MyTheme.background : MyTheme.text),
                    ),
                    Text(
                      "Measurements Taken Worker will start work soon",
                      style: TextStyle(
                          fontSize: 15,
                          color:
                              true ? MyTheme.background : Colors.transparent),
                    ),
                  ],
                )),
            MyTimeLineTile(
              isFirst: false,
              isLast: false,
              isPast: true,
              eventCard: Column(
                children: [
                  Text(
                    "Work Done",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: true ? MyTheme.background : MyTheme.text),
                  ),
                  Text(
                    "You can give Payment",
                    style: TextStyle(
                        fontSize: 15,
                        color: true ? MyTheme.background : Colors.transparent),
                  ),
                ],
              ),
            ),
            MyTimeLineTile(
                isFirst: false,
                isLast: true,
                isPast: false,
                eventCard: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const UpiPaymentScreen()),
                    // );
                  },
                  child: Column(
                    children: [
                      Text(
                        "Payment Done",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: false ? MyTheme.background : MyTheme.text),
                      ),
                      Text(
                        "Payment Done",
                        style: TextStyle(
                            fontSize: 15,
                            color: false
                                ? MyTheme.background
                                : Colors.transparent),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
