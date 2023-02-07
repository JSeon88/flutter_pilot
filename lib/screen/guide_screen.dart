import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pilot/repository/guide_repository.dart';
import 'package:flutter_pilot/screen/guide_detail_screen.dart';

import '../model/guide_model.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuideScreenState();

}

class _GuideScreenState extends State<GuideScreen> with AutomaticKeepAliveClientMixin{
  late GuideRepository guideRepository;
  List<GuideModel> list = [];

  Future _fetchList() async {
    try {
      List<GuideModel> res = await guideRepository.getGuideList();
      setState(() {
        list = res;
      });
    }on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    guideRepository = GuideRepository();
    _fetchList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int itemCount = list.length;

    return Scaffold(
      body: itemCount > 0 ? ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          final guideItem = list[index];

          return ListTile(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) => GuideDetailScreen(guideModel: guideItem,)
                  )
              )
            },
            title: Text(guideItem.title),
            subtitle: Text(guideItem.tags.join(", ")),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(guideItem.register),
                Text(formatDate(guideItem.date, [yyyy,'-',mm,'-',dd]))
              ],
            ),
          );
        },
      )
          : const Center(child: Text('No items')),
    );
  }

  @override
  bool get wantKeepAlive => true;
}