import 'package:flutter/foundation.dart';
import 'package:flutter_pilot/repository/guide_repository.dart';

import '../model/guide_model.dart';

class GuideProvider extends ChangeNotifier{
  final GuideRepository repository;
  late List<GuideModel> _guideList = [];

  String _selectedTag = "태그1";
  final List<String> _allTags = [];

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

  void changeTag ({
    required String tag
  }) {
    _selectedTag = tag;
    _allTags.add(tag);
    notifyListeners();
  }

  void deleteTag({
    required String tag
  }) {
    _allTags.removeWhere((element) => element == tag);
    notifyListeners();
  }

  get list => _guideList;
  get tagList => _allTags;
  get selectedTag => _selectedTag;
}