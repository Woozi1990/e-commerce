import 'package:e_commerce/api/home.dart';
import 'package:e_commerce/models/home.dart';
import 'package:e_commerce/widgets/home/best_sellers_section.dart';
import 'package:e_commerce/widgets/home/carousel_section.dart';
import 'package:e_commerce/widgets/home/category_section.dart';
import 'package:e_commerce/widgets/home/product_feed_section.dart';
import 'package:e_commerce/widgets/home/recommended_section.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CarouselItem> _carouselList = [];
  List<CategoryItem> _categoryList = [];

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: CarouselSection(carouselList: _carouselList)),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: CategorySection(categoryList: _categoryList),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: RecommendedSection(),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: BestSellersSection(name: "爆款推荐")),
              const SizedBox(width: 10),
              Expanded(child: BestSellersSection(name: "今日最佳")),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),

      ProductFeedSection(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _getCarouselList();
    _getCategoryList();
  }

  // Get carousel list
  void _getCarouselList() async {
    _carouselList = await getCarouselListAPI();
    setState(() {});
  }

  // Get category list
  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
