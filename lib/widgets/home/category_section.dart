import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 80,
            color: Colors.blue,
            child: Text("分类$index", style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}

