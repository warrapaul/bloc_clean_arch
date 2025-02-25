import 'package:bloc_clean_arch/common/widgets/tuts/carousel/components/carousel_dots.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/carousel/components/carousel_dots_n_arrows.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/carousel/components/simple_carousel_slider.dart';
import 'package:flutter/material.dart';

//
/*
CarouselSlider params
- items - list
- options - CarouselOptions

* options 
> height - double
> initialPage - int
> enableInfiniteScroll - boolean
> enlargeCenterPage - boolean  (middle one appears larger than others)

> autoPlay - boolean
> autoPlayInterval - Duration
> autoPlayAnimationDuration - duration
> scrollDirection - Axis.

> aspectRatio (ignored if height is provided)
> reverse - boolean
> autoPlayCurve - Curves.




*** CarouselSlider.builder  - builds items on demand (only when visible) saving memory by building widgets only when necessary




*** carouselController: <CarouselSliderController >- for manually controlling pageview's position
* optionally set duration and curves  -  controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.linear)
* CarouselSliderController methods 

animate to next and prev
> .nextPage({Duration duration, Curve curve})
> .previousPage({Duration duration, Curve curve})

animate to a page
> .animateToPage(int page, {Duration duration, Curve curve})

jump to a page
> .jumpToPage(int page)

 */
class CCarouselSlider extends StatelessWidget {
  const CCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: ListView(
        children: const [
          SimpleCarouselSlider(), 
          SizedBox(height: 10), 
          CarouselDots(),
          SizedBox(height: 10), 
          CarouselDotsNArrows(),
          SizedBox(height: 30), 

        ],
      )),
    );
  }
}
