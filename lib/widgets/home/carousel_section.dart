import 'package:flutter/material.dart';

class CarouselSection extends StatefulWidget {
  const CarouselSection({super.key});

  @override
  State<CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<CarouselSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      color: Colors.blue,
      child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
