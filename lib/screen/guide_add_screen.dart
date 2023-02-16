import 'package:flutter/material.dart';
import 'package:flutter_pilot/model/guide_model.dart';
import 'package:flutter_pilot/screen/guide_screen.dart';

import '../repository/guide_repository.dart';

class GuideAddScreen extends StatefulWidget {
  const GuideAddScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuideAddScreenState();

}

class _GuideAddScreenState extends State<GuideAddScreen> {
  late GuideRepository guideRepository;
  final formKey = GlobalKey<FormState>();
  String _selectedValue = "태그1";
  final List<String> _allChips = [];
  Map<String, dynamic> form = {};

  void _onDeleted(chip) {
    setState(() {
      _allChips.removeWhere((element) => element == chip);
    });
  }

  Future _createGuide(GuideModel guideModel) async {
    try {
      await guideRepository.createGuide(guideModel: guideModel);
    }on Exception catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('되돌아가기'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      renderTextFormField(
                        label: '제목',
                        isText: true,
                        onSaved: (val) {
                          form['title'] = val;
                        },
                        validator: (val) {
                          if(val.length < 1) {
                            return '제목은 필수사항입니다.';
                          }
                          return null;
                        },
                      ),
                      const Text(
                        '태그',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      DropdownButton(
                        value: _selectedValue,
                        items: dropdownItems,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue!;
                            _allChips.add(newValue);
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Wrap(
                            children: _allChips.map((chip) => Chip(
                              key: ValueKey(chip),
                              label: Text(chip),
                              backgroundColor: Colors.amber.shade200,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7,
                                  horizontal: 10
                              ),
                              deleteIconColor: Colors.red,
                              onDeleted: () => _onDeleted(chip),
                            )).toList()
                        ),
                      ),
                      renderTextFormField(
                        label: '내용',
                        isText: false,
                        onSaved: (val) {
                          form['content'] = val;
                        },
                        validator: (val) {
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                      color: Colors.blue[200],
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('취소')
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 10, 10),
                      color: Colors.grey[100],
                      child: ElevatedButton(
                          onPressed: () async {
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();

                              GuideModel guideModel = GuideModel(
                                  title: form['title'],
                                  tags: _allChips.toList(),
                                  content: form['content'],
                                  register: 'sunny',
                                  date: DateTime.now());

                              guideRepository = GuideRepository();
                              _createGuide(guideModel);

                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('등록하시겠습니까?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    // TODO 밑의 탭 버튼 확인 필요
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const GuideScreen(),
                                              maintainState: false
                                          )
                                      ),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const Text('저장')
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: "태그1", child: Text("태그1")),
    DropdownMenuItem(value: "태그2", child: Text("태그2")),
    DropdownMenuItem(value: "태그3", child: Text("태그3")),
    DropdownMenuItem(value: "태그4", child: Text("태그4")),
  ];
  return menuItems;
}

renderTextFormField({
  required String label,
  required bool isText,
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      TextFormField(
        minLines: isText ? 1 : 10,
        maxLines: isText ? 1 : null,
        keyboardType: TextInputType.multiline,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.blue[50]
        ),
      ),
      Container(height: 16.0),
    ],
  );
}
