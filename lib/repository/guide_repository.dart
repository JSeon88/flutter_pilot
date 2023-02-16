
import 'dart:io';

import 'package:dio/dio.dart';

import '../model/guide_model.dart';

class GuideRepository {
  final _dio = Dio();
  final _targetUrl = 'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/guide';

  // 가이드 리스트 가져오기
  Future<List<GuideModel>> getGuideList() async {
    final res = await _dio.get(
      _targetUrl,
    );
    return res.data.map<GuideModel>(
            (x) => GuideModel.fromJson(
        json: x
      ),
    ).toList();
  }

  // 가이드 등록
  Future<GuideModel> createGuide({
    required GuideModel guideModel
  }) async {
    final json = guideModel.toJson();

    final res = await _dio.post(_targetUrl, data: json);

    return GuideModel.fromJson(json: res.data);
  }
}