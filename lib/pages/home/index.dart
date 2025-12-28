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
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: CarouselSection()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: CategorySection()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: RecommendedSection()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: BestSellersSection(name: "爆款推荐")),
              SizedBox(width: 10),
              Expanded(child: BestSellersSection(name: "今日最佳")),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      ProductFeedSection(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
