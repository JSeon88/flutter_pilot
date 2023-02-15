import 'package:flutter/material.dart';

import '../model/guide_model.dart';

class GuideDetailScreen extends StatelessWidget {
  final GuideModel guideModel;

  const GuideDetailScreen({
    required this.guideModel,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('되돌아가기'),
        centerTitle: false,
      ),
      body: Center(
        child: Text(guideModel.content),
      ),
    );
  }
}