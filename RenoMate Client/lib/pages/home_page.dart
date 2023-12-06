import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/home_page_controller.dart';
import 'package:renomateclient/theme.dart';

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            crossAxisCount: 2),
                    itemCount: controller.workCardData.length,
                    itemBuilder: (context, index) {
                      return workCard(
                          controller.workCardData[index]["toolIcon"],
                          controller.workCardData[index]["title"],
                          controller.workCardData[index]["mainRoundBack"],
                          controller.workCardData[index]["smallRoundBack"],
                          controller.workCardData[index]["onClick"]);
                    }),
              ),
            ),
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

  Widget workCard(IconData toolIcon, String title, Color mainRoundBack,
      Color smallRoundBack, VoidCallback? onClick) {
    double width = MediaQuery.of(controller.context).size.width;
    // double _height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        // height: _width * .41,
        // width: _width * .41,
        decoration: BoxDecoration(
            color: MyTheme.accent,
            borderRadius: BorderRadius.circular(width * .08)
            // borderRadius: BorderRadius.only(
            //   topRight: Radius.circular(30),
            //   bottomLeft: Radius.circular(30),
            //   bottomRight: Radius.circular(30),
            // ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: width * 0.18,
              width: width * 0.18,
              decoration: BoxDecoration(
                color: mainRoundBack,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: smallRoundBack,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Icon(toolIcon, size: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: MyTheme.title,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void animateToSlide(int index) =>
      controller.carouselController.value.animateToPage(index);
  Widget buildImage(Image myImage, int index) => myImage;
}
