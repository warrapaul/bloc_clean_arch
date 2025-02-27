import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselDots extends StatefulWidget {
  const CarouselDots({super.key});

  @override
  State<CarouselDots> createState() => _CarouselDotsState();
}
/*
to manually navigate using dots/buttons use smooth_page_indicator package or custom containers


*/

class _CarouselDotsState extends State<CarouselDots> {
  int activeIndex = 0;
  CarouselSliderController controller = CarouselSliderController();

  List<String> countries = [
    "Kenya",
    "INDIA",
    "JAPAN",
    "AUSTRALIA",
    "RUSSIA",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: countries.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Colors.green,
              child: Align(
                alignment: Alignment.center,
                child: Text(countries[itemIndex]),
              ),
            );
          },
          carouselController: controller,
          options: CarouselOptions(
            height: 300,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        buildDots(),
        // AnimatedSmoothIndicator(
        //   activeIndex: activeIndex,
        //   count: countries.length,
        //   effect: WormEffect(
        //     dotColor: Colors.grey,
        //     dotHeight: 10,
        //     dotWidth: 10,
        //     activeDotColor: Colors.green,
        //   ),
        // ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              controller.nextPage(
                  duration: const Duration(milliseconds: 200), curve: Curves.linear);
            },
            icon: const Icon(Icons.arrow_back)),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: countries.length,
          onDotClicked: (index) {
            controller.animateToPage(index);
          },
          effect: const WormEffect(
            dotColor: Colors.grey,
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.green,
          ),
        ),
        IconButton(
          onPressed: () => controller.nextPage(),
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
