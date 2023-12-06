import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/plumbing_page_controller.dart';
import 'package:renomateclient/controllers/wall_painting_page_controller.dart';
import 'package:renomateclient/pages/plumbing_page.dart';
import 'package:renomateclient/pages/wall_painting_page.dart';

class HomePageController extends GetxController {
  final activeIndex = 0.obs;
  final carouselController = Rx(CarouselController());
  late BuildContext context;

  void setActiveIndex(int index) {
    activeIndex.value = index;
  }

  void animateToSlide(int index) {
    carouselController.value.animateToPage(index);
  }

  List<Image> myImages = [
    Image.asset(
      'assets/images/OtherImgs/slider1.jpeg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/OtherImgs/slider2.jpeg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/OtherImgs/slider3.jpeg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/OtherImgs/slider4.jpeg',
      fit: BoxFit.cover,
    ),
  ];

  final List<Map<String, dynamic>> workCardData = [
    {
      "toolIcon": Icons.format_paint,
      "title": "Wall Painting",
      "mainRoundBack": const Color.fromRGBO(108, 92, 231, 1),
      "smallRoundBack": const Color.fromRGBO(162, 155, 254, 1),
      "onClick": () {
        Get.delete<WallPaintingPageController>();
        Get.to(WallPaintingPage());
      }
    },
    {
      "toolIcon": Icons.plumbing_rounded,
      "title": "Plumbing",
      "mainRoundBack": const Color.fromRGBO(225, 112, 85, 1),
      "smallRoundBack": const Color.fromRGBO(250, 177, 160, 1),
      "onClick": () {
        Get.delete<PlumbingPageController>();
        Get.to(PlumbingPage());
      }
    },
    {
      "toolIcon": Icons.power,
      "title": "Electrician",
      "mainRoundBack": const Color.fromRGBO(1, 163, 164, 1),
      "smallRoundBack": const Color.fromRGBO(0, 210, 211, 1),
      "onClick": () {}
    },
    {
      "toolIcon": Icons.more_vert_rounded,
      "title": "More",
      "mainRoundBack": const Color.fromRGBO(255, 159, 67, 1),
      "smallRoundBack": const Color.fromRGBO(254, 202, 87, 1),
      "onClick": () {}
    },
    // {
    //   "toolIcon": Icons.format_paint,
    //   "title": "Wall Painting",
    //   "mainRoundBack": const Color.fromRGBO(108, 92, 231, 1),
    //   "smallRoundBack": const Color.fromRGBO(162, 155, 254, 1),
    //   "onClick": () {}
    // },
    // {
    //   "toolIcon": Icons.plumbing_rounded,
    //   "title": "Plumbing",
    //   "mainRoundBack": const Color.fromRGBO(225, 112, 85, 1),
    //   "smallRoundBack": const Color.fromRGBO(250, 177, 160, 1),
    //   "onClick": () {}
    // },
    // {
    //   "toolIcon": Icons.power,
    //   "title": "Electrician",
    //   "mainRoundBack": const Color.fromRGBO(1, 163, 164, 1),
    //   "smallRoundBack": const Color.fromRGBO(0, 210, 211, 1),
    //   "onClick": () {}
    // },
    // {
    //   "toolIcon": Icons.more_vert_rounded,
    //   "title": "More",
    //   "mainRoundBack": const Color.fromRGBO(255, 159, 67, 1),
    //   "smallRoundBack": const Color.fromRGBO(254, 202, 87, 1),
    //   "onClick": () {}
    // },
  ];

  // final urlImages = [
  //   'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
  //   'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  //   'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
  //   'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  //   'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  // ];
}
