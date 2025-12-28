import 'package:flutter/material.dart';

class RecommendedSection extends StatefulWidget {
  const RecommendedSection({super.key});

  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 300,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text("推荐", style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
