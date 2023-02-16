import 'package:flutter/foundation.dart';
import 'package:flutter_pilot/repository/guide_repository.dart';

import '../model/guide_model.dart';

class GuideProvider extends ChangeNotifier{
  final GuideRepository repository;
  late List<GuideModel> _guideList = [];

  GuideProvider({
    required this.repository
  }) : super() {
    getGuides();
  }

  void getGuides() async {
    _guideList = await repository.getGuideList();
    notifyListeners();
  }

  void createGuide({
    required GuideModel guideModel
  }) async {
    GuideModel result = await repository.createGuide(guideModel: guideModel);
    _guideList.add(result);
    notifyListeners();
  }

  get list => _guideList;
}