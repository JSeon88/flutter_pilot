import 'package:flutter/material.dart';
import 'package:flutter_pilot/model/guide_model.dart';
import 'package:flutter_pilot/provider/guide_provider.dart';
import 'package:flutter_pilot/provider/tag_provider.dart';
import 'package:flutter_pilot/screen/guide_screen.dart';
import 'package:provider/provider.dart';

class GuideAddScreen extends StatelessWidget {
  const GuideAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Map<String, dynamic> form = {};

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TagProvider()),
          ChangeNotifierProvider(create: (_) => guideProvider),
        ],
        builder: (BuildContext context, child) {

          final tagProvider = context.watch<TagProvider>();
          final List<String> _allChips = tagProvider.tagList;

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
                                if (val.length < 1) {
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
                            DropdownButton<String>(
                              value: tagProvider.selectedTag,
                              items: dropdownItems,
                              onChanged: (String? newValue) {
                                if (newValue == null) {
                                  return;
                                }
                                tagProvider.changeTag(tag: newValue);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1),
                              child: Wrap(
                                  children: _allChips.map((chip) =>
                                      Chip(
                                        key: ValueKey(chip),
                                        label: Text(chip),
                                        backgroundColor: Colors.amber.shade200,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7,
                                            horizontal: 10
                                        ),
                                        deleteIconColor: Colors.red,
                                        onDeleted: () =>
                                            tagProvider.deleteTag(tag: chip),
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
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();

                                    context.read<GuideProvider>().createGuide(
                                        guideModel: GuideModel(
                                        title: form['title'],
                                        tags: _allChips.toList(),
                                        content: form['content'],
                                        register: 'sunny',
                                        date: DateTime.now()));

                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('등록하시겠습니까?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(
                                                        context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              // TODO 밑의 탭 버튼 확인 필요
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) => const GuideScreen(),
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
        },
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
