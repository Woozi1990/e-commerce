import 'package:e_commerce/models/home.dart';
import 'package:flutter/material.dart';

class RecommendedSection extends StatefulWidget {
  final RecommendItem recommendItem;
  const RecommendedSection({super.key, required this.recommendItem});

  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  List<GoodsItem> _getRecommendedItem() {
    if(widget.recommendItem.subTypes.isEmpty){
      return [];
    }
    return widget.recommendItem.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: const Color.fromARGB(255, 117, 29, 22),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        Text("精选省攻略", style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildLeft() {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("images/home/recommend_left.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getRecommendedItem();
    return List.generate(list.length, (int index) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "images/home/recommend_left.jpeg",
                  width: 120,
                  height: 140,
                  fit: BoxFit.cover,
                );
              },
              list[index].picture,
              width: 120,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20 ),
            ),
            child: Text(
              "￥${list[index].price}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("images/home/background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 10),
          Row(
            children: [
              _buildLeft(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _getChildrenList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
