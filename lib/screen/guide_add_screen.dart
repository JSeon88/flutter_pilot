import 'package:flutter/material.dart';

class GuideAddScreen extends StatefulWidget {
  const GuideAddScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuideAddScreenState();

}

class _GuideAddScreenState extends State<GuideAddScreen> {
  String selectedValue = "태그1";

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
                key: GlobalKey<FormState>(),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      renderTextFormField(
                        label: '제목',
                        isText: true,
                        onSaved: (val) {},
                        validator: (val) {
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
                        value: selectedValue,
                        items: dropdownItems,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                      ),
                      renderTextFormField(
                        label: '',
                        isText: true,
                        onSaved: (val) {},
                        validator: (val) {
                          return null;
                        },
                      ),
                      renderTextFormField(
                        label: '내용',
                        isText: false,
                        onSaved: (val) {},
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
                          child: Text('취소')
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 10, 10),
                      color: Colors.grey[100],
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text('저장')
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
  assert(onSaved != null);
  assert(validator != null);

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
          fillColor: Colors.grey[300]
        ),
      ),
      Container(height: 16.0),
    ],
  );
}
