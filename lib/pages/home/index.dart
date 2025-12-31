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
  RecommendItem _recommendItem = RecommendItem(id: "", title: "", subTypes: []);
  RecommendItem _bestSellersItem = RecommendItem(id: "", title: "", subTypes: []);
  RecommendItem _oneStopShopItem = RecommendItem(id: "", title: "", subTypes: []);

  List<Widget> _getScrollChildren() {
    return [
      //轮播图
      SliverToBoxAdapter(child: CarouselSection(carouselList: _carouselList)),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      
      //分类
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: CategorySection(categoryList: _categoryList),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),

      //推荐
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: RecommendedSection(recommendItem: _recommendItem),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),

      //爆款推荐 & 今日最佳
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: BestSellersSection(result:_bestSellersItem, type:"bestSellers")),
              const SizedBox(width: 10),
              Expanded(child: BestSellersSection(result:_oneStopShopItem, type:"oneStopShop")),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),

      //商品列表
      ProductFeedSection(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _getCarouselList();
    _getCategoryList();
    _getRecommendedList();
    _getBestSellersList();
    _getOneStopShopList();
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

  // Get recommended list
  void _getRecommendedList() async {
    _recommendItem = await getRecommendedListAPI();
    setState(() {});
  }

  // Get best sellers list
  void _getBestSellersList() async {
    _bestSellersItem = await getBestSellersListAPI();
    setState(() {});
  }

  // Get one stop shop list
  void _getOneStopShopList() async {
    _oneStopShopItem = await getOneStopShopAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
