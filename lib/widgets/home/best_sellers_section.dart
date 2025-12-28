import 'package:flutter/material.dart';

class BestSellersSection extends StatefulWidget {
  final String name;
  const BestSellersSection({super.key, required this.name});

  @override
  State<BestSellersSection> createState() => _BestSellersSectionState();
}

class _BestSellersSectionState extends State<BestSellersSection> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      height: 200,
      child: Text(widget.name, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
