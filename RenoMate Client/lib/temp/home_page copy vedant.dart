import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const IconData power = IconData(0xe4e0, fontFamily: 'MaterialIcons');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = [
    'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
    'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
    'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      // backgroundColor: const Color(0xff292C31),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = urlImages[index];
                        return buildImage(urlImage, index);
                      },
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 5,
                          autoPlay: true,
                          enableInfiniteScroll: false,
                          autoPlayAnimationDuration:
                              const Duration(seconds: 3),
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) =>
                              setState(() => activeIndex = index))),
                ],
              ),
              // Container(
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 5, 250, 0),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   // color: Color.fromARGB(255, 5, 250, 0),
              //   width: double.infinity,
              //   height: MediaQuery.of(context).size.height / 5,
              //   child: SvgPicture.asset(
              //     "assets/images/logos/logo_main_white.svg",
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ),
            const SizedBox(
              height: 1,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(118, 118, 118, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: width * .41,
                        width: width * .41,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(118, 118, 118, 1),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: width * 0.18,
                              width: width * 0.18,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(108, 92, 231, 1),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        162, 155, 254, 1),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: const Icon(
                                    Icons.format_paint,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Wall Painting",
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: width * .41,
                        width: width * .41,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(118, 118, 118, 1),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: width * 0.18,
                              width: width * 0.18,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(225, 112, 85, 1),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        250, 177, 160, 1),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: const Icon(
                                    Icons.plumbing_rounded,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Plumbing",
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: width * .41,
                        width: width * .41,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(118, 118, 118, 1),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: width * 0.18,
                              width: width * 0.18,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(1, 163, 164, 1),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(0, 210, 211, 1),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: const Icon(
                                    Icons.power,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Electrician",
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: width * .41,
                        width: width * .41,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(118, 118, 118, 1),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: width * 0.18,
                              width: width * 0.18,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 159, 67, 1),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(254, 202, 87, 1),
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: const Icon(
                                    Icons.more_vert_rounded,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "More",
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 1,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(118, 118, 118, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget workCard(IconData toolIcon, String title, Color mainRoundBack,
      Color smallRoundBack, Function onClick) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      height: width * .41,
      width: width * .41,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(118, 118, 118, 1),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
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
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: smallRoundBack,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Icon(toolIcon, size: 35),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Wall Painting",
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 15, activeDotColor: Colors.blue),
        activeIndex: activeIndex,
        count: urlImages.length,
      );
  void animateToSlide(int index) => controller.animateToPage(index);
  Widget buildImage(String urlImage, int index) =>
      Image.network(urlImage, fit: BoxFit.cover);
}
