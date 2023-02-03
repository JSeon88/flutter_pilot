import 'package:flutter/material.dart';
import 'package:flutter_pilot/screen/guide_detail_screen.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuideScreenState();

}

class _GuideScreenState extends State<GuideScreen> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const int itemCount = 50;

    return Scaffold(
      body: itemCount > 0 ? ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) => GuideDetailScreen()
                  )
              )
            },
            title: Text('제목입니다 ${index + 1}'),
            subtitle: const Text('#태그1 #태그2 #태그3'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('작성자'),
                Text('yyyy-mm-dd')
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