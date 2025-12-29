import 'package:e_commerce/models/home.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  final List<CategoryItem> categoryList;
  const CategorySection({super.key, required this.categoryList});

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
        itemCount: widget.categoryList.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (BuildContext context, int index) {
          final category = widget.categoryList[index];

          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromRGBO(239, 235, 235, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture, width: 40, height: 40),
                // const SizedBox(height: 5),
                Text(
                  category.name,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),

          );
        },
      ),
    );
  }
}
