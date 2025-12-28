import 'package:flutter/material.dart';

class ProductFeedSection extends StatefulWidget {
  const ProductFeedSection({super.key});

  @override
  State<ProductFeedSection> createState() => _ProductFeedSectionState();
}

class _ProductFeedSectionState extends State<ProductFeedSection> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              "商品",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
