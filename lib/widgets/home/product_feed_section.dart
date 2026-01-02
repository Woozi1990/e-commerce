import 'package:e_commerce/models/home.dart';
import 'package:flutter/material.dart';

class ProductFeedSection extends StatefulWidget {
  final List<ProductFeedItem> productFeedList;
  const ProductFeedSection({super.key, required this.productFeedList});

  @override
  State<ProductFeedSection> createState() => _ProductFeedSectionState();
}

class _ProductFeedSectionState extends State<ProductFeedSection> {
  Widget _getChildren(int index) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Image.network(
              widget.productFeedList[index].picture,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/home/recommend_left.jpeg",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.productFeedList[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "￥${widget.productFeedList[index].price}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  // children: [
                  //   TextSpan(text: " "),
                  //   TextSpan(
                  //     text: widget.productFeedList[index].price,
                  //     style: TextStyle(
                  //       decoration: TextDecoration.lineThrough,
                  //       fontSize: 12,
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ],
                ),
              ),
              Text(
                "${widget.productFeedList[index].payCount}人已购买",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: widget.productFeedList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _getChildren(index),
        );
      },
    );
  }
}
