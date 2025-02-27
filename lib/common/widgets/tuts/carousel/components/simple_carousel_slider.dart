import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SimpleCarouselSlider extends StatelessWidget {
  const SimpleCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(builder: (context) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(color: Colors.amber),
              child: Text(
                'text $i',
                style: const TextStyle(fontSize: 16.0),
              ),
            );
          });
        }).toList(),
        options: CarouselOptions(
          height: 200,
          enlargeCenterPage: true,
                enlargeFactor: 0.3,

          ),
          );
  }
}
