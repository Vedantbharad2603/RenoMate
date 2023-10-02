import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:renomate/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  // static const IconData power = IconData(0xe4e0, fontFamily: 'MaterialIcons');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  final controller = CarouselController();
  // final urlImages = [
  //   'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
  //   'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  //   'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
  //   'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  //   'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  // ];
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

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> workCardData = [
      {
        "toolIcon": Icons.format_paint,
        "title": "Wall Painting",
        "mainRoundBack": Color.fromRGBO(108, 92, 231, 1),
        "smallRoundBack": Color.fromRGBO(162, 155, 254, 1),
        "onClick": () {}
      },
      {
        "toolIcon": Icons.plumbing_rounded,
        "title": "Plumbing",
        "mainRoundBack": Color.fromRGBO(225, 112, 85, 1),
        "smallRoundBack": Color.fromRGBO(250, 177, 160, 1),
        "onClick": () {}
      },
      {
        "toolIcon": Icons.power,
        "title": "Electrician",
        "mainRoundBack": Color.fromRGBO(1, 163, 164, 1),
        "smallRoundBack": Color.fromRGBO(0, 210, 211, 1),
        "onClick": () {}
      },
      {
        "toolIcon": Icons.more_vert_rounded,
        "title": "More",
        "mainRoundBack": Color.fromRGBO(255, 159, 67, 1),
        "smallRoundBack": Color.fromRGBO(254, 202, 87, 1),
        "onClick": () {}
      },
      {
        "toolIcon": Icons.format_paint,
        "title": "Wall Painting",
        "mainRoundBack": Color.fromRGBO(108, 92, 231, 1),
        "smallRoundBack": Color.fromRGBO(162, 155, 254, 1),
        "onClick": () {}
      },
      {
        "toolIcon": Icons.plumbing_rounded,
        "title": "Plumbing",
        "mainRoundBack": Color.fromRGBO(225, 112, 85, 1),
        "smallRoundBack": Color.fromRGBO(250, 177, 160, 1),
        "onClick": () {}
      },
      {
        "toolIcon": Icons.power,
        "title": "Electrician",
        "mainRoundBack": Color.fromRGBO(1, 163, 164, 1),
        "smallRoundBack": Color.fromRGBO(0, 210, 211, 1),
        "onClick": () {}
      },
      {
        "toolIcon": Icons.more_vert_rounded,
        "title": "More",
        "mainRoundBack": Color.fromRGBO(255, 159, 67, 1),
        "smallRoundBack": Color.fromRGBO(254, 202, 87, 1),
        "onClick": () {}
      },
    ];

    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: MyTheme.background,
      // backgroundColor: const Color(0xff292C31),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: myImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final myImage = myImages[index];
                        return buildImage(myImage, index);
                      },
                      options: CarouselOptions(
                        height: _height * 0.19,
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        autoPlayAnimationDuration: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                    ),
                    SizedBox(height: (_height * 0.01))
                  ],
                ),
              ),
              horizontalLine(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          crossAxisCount: 2),
                      itemCount: workCardData.length,
                      itemBuilder: (context, index) {
                        return workCard(
                            workCardData[index]["toolIcon"],
                            workCardData[index]["title"],
                            workCardData[index]["mainRoundBack"],
                            workCardData[index]["smallRoundBack"],
                            workCardData[index]["onClick"]);
                      }),
                ),
              ),
              horizontalLine(),
            ],
          ),
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
    double _width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        // height: _width * .41,
        // width: _width * .41,
        decoration: BoxDecoration(
            color: MyTheme.accent,
            borderRadius: BorderRadius.circular(_width * .08)
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
              height: _width * 0.18,
              width: _width * 0.18,
              decoration: BoxDecoration(
                color: mainRoundBack,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: smallRoundBack,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Icon(toolIcon, size: 35),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
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

  void animateToSlide(int index) => controller.animateToPage(index);
  Widget buildImage(Image myImage, int index) => myImage;
}
