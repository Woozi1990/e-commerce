class CarouselItem {
  String id;
  String imgUrl;
  CarouselItem({required this.id, required this.imgUrl});

  factory CarouselItem.formJSON(Map<String, dynamic> json) {
    return CarouselItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });

  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] == null
          ? null
          : (json["children"] as List)
                .map(
                  (item) => CategoryItem.formJSON(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.picture,
    required this.price,
    required this.orderNum,
  });

  factory GoodsItem.formJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id']?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      desc: json["desc"]?.toString(),
      picture: json["picture"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      orderNum: int.tryParse(json['orderNum']?.toString() ?? "") ?? 0,
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.formJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: int.tryParse(json['counts']?.toString() ?? "") ?? 0,
      pageSize: int.tryParse(json['pageSize']?.toString() ?? "") ?? 0,
      pages: int.tryParse(json['pages']?.toString() ?? "") ?? 0,
      page: int.tryParse(json['page']?.toString() ?? "") ?? 0,
      items: (json["items"] as List? ?? [])
          .map((item) => GoodsItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.formJSON(Map<String, dynamic> json) {
    return SubType(
      id: json['id']?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      goodsItems: GoodsItems.formJSON(
        json["goodsItems"] as Map<String, dynamic>,
      ),
    );
  }
}

class RecommendItem {
  String id;
  String title;
  List<SubType> subTypes;
  RecommendItem({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory RecommendItem.formJSON(Map<String, dynamic> json) {
    return RecommendItem(
      id: json['id']?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      subTypes: (json["subTypes"] as List? ?? [])
          .map((item) => SubType.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProductFeedItem extends GoodsItem {
  int payCount = 0;

  ProductFeedItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }):super(desc: "");

  factory ProductFeedItem.formJSON(Map<String, dynamic> json) {
    return ProductFeedItem(
      id: json['id']?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json['orderNum']?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json['payCount']?.toString() ?? "0") ?? 0,
    );
  }
}

