import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:renomateworker/controllers/details_page_controller.dart';
import 'package:renomateworker/controllers/home_page_controller.dart';
import 'package:renomateworker/pages/details_page.dart';
import 'package:renomateworker/theme.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    controller.context = context;

    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: MyTheme.background,
      // backgroundColor: const Color(0xff292C31),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    carouselController: controller.carouselController.value,
                    itemCount: controller.myImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final myImage = controller.myImages[index];
                      return buildImage(myImage, index);
                    },
                    options: CarouselOptions(
                      height: height * 0.19,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) =>
                          controller.setActiveIndex(index),
                    ),
                  ),
                  SizedBox(height: (height * 0.01))
                ],
              ),
            ),
            horizontalLine(),
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
                  "My Ongoing Work",
                  style: TextStyle(color: MyTheme.title, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            myworkList(context, "Enamel paint", false, "Full Renovation",
                "5/12/2023", "49261", height),
            myworkList(context, "Textured Paint", true, "Wall Painting",
                "16/1/24", "65258", height),
            horizontalLine(),
          ],
        ),
      ),
    );
  }

  Widget horizontalLine() {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MyTheme.accent,
        ),
      ),
    );
  }

  Widget myworkList(BuildContext context, String worktype, bool isdone,
      String about, String date, String amount, double _height) {
    return Padding(
      padding: EdgeInsets.all(_height * 0.011),
      child: Container(
        decoration: BoxDecoration(
          color: MyTheme.accent,
          borderRadius: BorderRadius.circular(_height * 0.02),
        ),
        padding: const EdgeInsets.all(10),
        // height: _height * 0.16,
        child: InkWell(
          onTap: () {
            Get.delete<DetailsPageController>();
            Get.to(DetailsPage());
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
                            worktype,
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
                                date,
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
                                about,
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

  void animateToSlide(int index) =>
      controller.carouselController.value.animateToPage(index);
  Widget buildImage(Image myImage, int index) => myImage;
}
