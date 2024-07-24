import 'package:flutter/material.dart';

class HomeBottomInfo extends StatefulWidget {
  const HomeBottomInfo({super.key});

  @override
  State<HomeBottomInfo> createState() => _HomeBottomInfoState();
}

class _HomeBottomInfoState extends State<HomeBottomInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey.shade700,
      child: const Center(
        child: FlutterLogo(),
      ),
    );
  }
}
