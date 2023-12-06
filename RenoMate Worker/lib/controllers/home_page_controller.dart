import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  // final urlImages = [
  //   'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
  //   'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  //   'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
  //   'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  //   'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  // ];
}
