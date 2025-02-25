import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselDotsNArrows extends StatefulWidget {
  const CarouselDotsNArrows({super.key});
  
  @override
  State<CarouselDotsNArrows> createState() => _CarouselDotsState();
}

class _CarouselDotsState extends State<CarouselDotsNArrows> {
  int activeIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  final List<String> countries = [
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
        Stack(
          children: [
            CarouselSlider.builder(
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                return Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
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
            // Navigation Arrows
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Arrow
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: IconButton(
                        onPressed: () => controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Right Arrow
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: IconButton(
                        onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Dots Indicator
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: countries.length,
          onDotClicked: (index) {
            controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          effect: const WormEffect(
            dotColor: Colors.grey,
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.green,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}