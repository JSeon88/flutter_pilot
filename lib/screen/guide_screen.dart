import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pilot/provider/guide_provider.dart';
import 'package:flutter_pilot/screen/guide_add_screen.dart';
import 'package:flutter_pilot/screen/guide_detail_screen.dart';
import 'package:provider/provider.dart';

import '../model/guide_model.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guideProvider = context.watch<GuideProvider>();
    List<GuideModel> list = guideProvider.list;
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext bc) => GuideAddScreen()
              )
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }


}