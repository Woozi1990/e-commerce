import 'package:e_commerce/models/home.dart';

class MeRecommendItem{
  int counts;
  int pageSize;
  int pages;
  int page;
  List<ProductFeedItem> items;
  MeRecommendItem({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory MeRecommendItem.formJSON(Map<String, dynamic> json) {
    return MeRecommendItem(
      counts: int.tryParse(json['counts']?.toString() ?? "") ?? 0,
      pageSize: int.tryParse(json['pageSize']?.toString() ?? "") ?? 0,
      pages: int.tryParse(json['pages']?.toString() ?? "") ?? 0,
      page: int.tryParse(json['page']?.toString() ?? "") ?? 0,
      items: (json["items"] as List? ?? [])
          .map((item) => ProductFeedItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}