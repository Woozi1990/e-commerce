import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/models/home.dart';
import 'package:flutter/material.dart';

class CarouselSection extends StatefulWidget {
  final List<CarouselItem> carouselList;
  const CarouselSection({super.key, required this.carouselList});

  @override
  State<CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<CarouselSection> {
  
  Widget _getCarouselItem() {
    //get screen width
    final double screenWidth=MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: List.generate(widget.carouselList.length, (int index) {
        return Image.network(widget.carouselList[index].imgUrl,
        fit: BoxFit.cover,
        width: screenWidth,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getCarouselItem()]);
  }
}
