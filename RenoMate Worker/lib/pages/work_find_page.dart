import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:renomateworker/models/wall_painting_model.dart';
import 'package:renomateworker/pages/work_details_page.dart';
import 'package:renomateworker/theme.dart';

class WorkFindPage extends StatelessWidget {
  const WorkFindPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    // Static list of WallPaintingModel instances
    List<WallPaintingModel> staticWorkList = [
      WallPaintingModel(
        tillDate: DateTime.now(),
        selectedType: 'Enamel paint',
        imagePath: 'path_to_image1.jpg',
        referenceImagePath: null,
        information: 'Full Renovation',
        userLatitude: 0.0,
        userLongitude: 0.0,
      ),
      WallPaintingModel(
        tillDate: DateTime.now(),
        selectedType: 'Textured Paint',
        imagePath: 'path_to_image2.jpg',
        referenceImagePath: null,
        information: 'Wall Painting',
        userLatitude: 0.0,
        userLongitude: 0.0,
      ),
    ];

    return Scaffold(
      backgroundColor: MyTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: _width * 0.08,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: _width * 0.1,
                width: _width * 0.4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyTheme.button1,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Find New Work',
                  style: TextStyle(
                    color: MyTheme.background,
                    fontWeight: FontWeight.w600,
                    fontSize: _width * 0.045,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _width * 0.08,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: staticWorkList.length,
                itemBuilder: (context, index) {
                  return myWorkList(context, staticWorkList[index], _width);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myWorkList(
      BuildContext context, WallPaintingModel work, double _width) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(work.tillDate);
    return Padding(
      padding: EdgeInsets.all(_width * 0.025),
      child: Container(
        decoration: BoxDecoration(
          color: MyTheme.accent,
          borderRadius: BorderRadius.circular(_width * 0.02),
        ),
        padding: EdgeInsets.all(10),
        // height: 140,
        child: InkWell(
          onTap: () {
            Get.delete<WorkDetailsPage>();
            Get.to(WorkDetailsPage(work: work));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            work.selectedType,
                            style: TextStyle(
                                color: MyTheme.text,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Date :- ",
                                style: TextStyle(
                                  color: MyTheme.text,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: MyTheme.text,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Moe Info :- ",
                                style: TextStyle(
                                  color: MyTheme.text,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                work.information,
                                style: TextStyle(
                                    color: MyTheme.text,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: MyTheme.text,
                      size: 36,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
