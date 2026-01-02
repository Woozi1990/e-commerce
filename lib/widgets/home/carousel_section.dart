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
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;
  Widget _getCarouselItem() {
    //get screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _controller,
      items: List.generate(widget.carouselList.length, (int index) {
        return Image.network(
          widget.carouselList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: "Search..",
              hintStyle: TextStyle(color: Colors.white, fontSize: 16),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getIndicator() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.carouselList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.animateToPage(index);
              },
              child: AnimatedContainer(
                height: 6,
                width: index == _currentIndex ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                duration: Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: index == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getCarouselItem(), _getSearch(), _getIndicator()]);
  }
}
