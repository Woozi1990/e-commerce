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
