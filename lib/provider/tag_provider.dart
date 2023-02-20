import 'package:flutter/foundation.dart';

class TagProvider extends ChangeNotifier {

  String _selectedTag = "태그1";
  final List<String> _allTags = [];

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

  get tagList => _allTags;
  get selectedTag => _selectedTag;
}