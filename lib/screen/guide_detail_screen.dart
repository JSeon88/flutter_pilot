import 'package:flutter/material.dart';

class GuideDetailScreen extends StatelessWidget {
  const GuideDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('Online Contact'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('상세보기'),
      ),
    );
  }

}