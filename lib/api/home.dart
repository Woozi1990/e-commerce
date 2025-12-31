import 'package:e_commerce/constants/index.dart';
import 'package:e_commerce/models/home.dart';
import 'package:e_commerce/utils/dio_request.dart';

Future<List<CarouselItem>> getCarouselListAPI() async {
  return ((await dioRequest.get(HttpConstants.carouselList)) as List).map((
    item,
  ) {
    return CarouselItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  return ((await dioRequest.get(HttpConstants.categoryList)) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

Future<RecommendItem> getRecommendedListAPI() async {
  return RecommendItem.formJSON(
    await dioRequest.get(HttpConstants.recommendedList),
  );
}

Future<RecommendItem> getBestSellersListAPI() async {
  return RecommendItem.formJSON(
    await dioRequest.get(HttpConstants.bestSellersList),
  );
}

Future<RecommendItem> getOneStopShopAPI() async {
  return RecommendItem.formJSON(
    await dioRequest.get(HttpConstants.oneStopShop),
  );
}

Future<List<ProductFeedItem>> getProductFeedListAPI(
  Map<String, dynamic> params,
) async {
  return ((await dioRequest.get(HttpConstants.productFeedList, params: params))
          as List)
      .map((item) {
        return ProductFeedItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
