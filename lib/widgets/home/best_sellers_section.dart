import 'package:e_commerce/models/home.dart';
import 'package:flutter/material.dart';

class BestSellersSection extends StatefulWidget {
  final RecommendItem result;
  final String type;

  const BestSellersSection({super.key, required this.result, required this.type});

  @override
  State<BestSellersSection> createState() => _BestSellersSectionState();
}

class _BestSellersSectionState extends State<BestSellersSection> {

  List<GoodsItem> get _items {
    if(widget.result.subTypes.isEmpty){
      return [];
    }
    return widget.result.subTypes.first.goodsItems.items
        .take(2)
        .toList();
  }

  List<Widget> _getChildrenList() {
    return _items.map((item){
      return Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.picture,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "images/home/recommend_left.jpeg",
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            Text(
              "￥${item.price}",
              style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 104, 28, 23)),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "bestSellers" ? "爆款推荐" : "一站买全",
          style: TextStyle(
            color: const Color.fromARGB(255, 117, 29, 22),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "bestSellers" ? "大家都在买的商品" : "精选优质好物", 
          style: TextStyle(fontSize: 10, 
          color: Colors.grey)),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.type == "bestSellers"? Color.fromARGB(255, 224, 169, 169) : Color.fromARGB(255, 240, 255, 240),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _getChildrenList(),
            ),
          ],
      ),
    )
    );
  }
}
