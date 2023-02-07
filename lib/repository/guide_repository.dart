
import 'dart:io';

import 'package:dio/dio.dart';

import '../model/guide_model.dart';

class GuideRepository {
  final _dio = Dio();
  final _targetIrl = 'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/list';

  Future<List<GuideModel>> getGuideList() async {
    final res = await _dio.get(
      _targetIrl,
    );
    return res.data.map<GuideModel>(
            (x) => GuideModel.fromJson(
        json: x
      ),
    ).toList();
  }
}