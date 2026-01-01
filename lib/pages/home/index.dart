import 'package:e_commerce/api/home.dart';
import 'package:e_commerce/models/home.dart';
import 'package:e_commerce/utils/toast_utils.dart';
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
  RecommendItem _bestSellersItem = RecommendItem(
    id: "",
    title: "",
    subTypes: [],
  );
  RecommendItem _oneStopShopItem = RecommendItem(
    id: "",
    title: "",
    subTypes: [],
  );
  List<ProductFeedItem> _productFeedList = [];
  final ScrollController _controller = ScrollController();

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
              Expanded(
                child: BestSellersSection(
                  result: _bestSellersItem,
                  type: "bestSellers",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BestSellersSection(
                  result: _oneStopShopItem,
                  type: "oneStopShop",
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),

      //商品列表
      ProductFeedSection(productFeedList: _productFeedList),
    ];
  }

  @override
  void initState() {
    super.initState();
    _registerEvent();
    Future.microtask(() {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        // Reached the bottom

        _getProductFeedList();
      }
    });
  }

  // Get carousel list
  Future<void> _getCarouselList() async {
    _carouselList = await getCarouselListAPI();
  }

  // Get category list
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  // Get recommended list
  Future<void> _getRecommendedList() async {
    _recommendItem = await getRecommendedListAPI();
  }

  // Get best sellers list
  Future<void> _getBestSellersList() async {
    _bestSellersItem = await getBestSellersListAPI();
  }

  // Get one stop shop list
  Future<void> _getOneStopShopList() async {
    _oneStopShopItem = await getOneStopShopAPI();
  }

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  // Get product feed list
  Future<void> _getProductFeedList() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;

    int requestLimit = _page * 10;
    _productFeedList = await getProductFeedListAPI({"limit": requestLimit});
    _isLoading = false;

    if (_productFeedList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await Future.wait([
      _getCarouselList(),
      _getCategoryList(),
      _getRecommendedList(),
      _getBestSellersList(),
      _getOneStopShopList(),
      _getProductFeedList(),
    ]);


    if(!mounted) return;
    setState(() {});
    ToastUtils.showToast(context, "刷新成功");
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: CustomScrollView(
        controller: _controller,
        slivers: _getScrollChildren(),
      ),
    );
  }
}
