import 'package:flutter/material.dart';

import '../../../data/app_data.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({super.key});

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppData.color,
            width: 5.0,
          ),
        ),
      ),
      child: const Center(
        child: FlutterLogo(),
      ),
    );
  }
}
