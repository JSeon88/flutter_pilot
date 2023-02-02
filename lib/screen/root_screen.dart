import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pilot/screen/home_screen.dart';

class RootScreen extends StatefulWidget{
  const RootScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RootScreenState();

}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin{
  TabController? tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
    tabController!.addListener(tabListener);


  }

  tabListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('Online Contact'),
        centerTitle: true,
      ),
      body: TabBarView(
            controller: tabController,
            children: renderChildren(),
          ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  @override
  void dispose() {
    tabController!.removeListener(tabListener);
    super.dispose();
  }


  List<Widget> renderChildren() {
    return [
      HomeScreen(),
      SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  10,
                      (index) => Flexible(
                    child: Container(
                      height: 50,
                      color: Color(Random().nextInt(0xffffffff)),
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Text("top item $index"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const Center(
        child: Text('탭3'),
      ),
      const Center(
        child: Text('탭4'),
      )
    ];
  }


  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: tabController!.index,
      onTap: (int index) {
        setState(() {
          tabController!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.airplane_ticket_outlined,
          ),
          label: '티켓',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.grading,
          ),
          label: '가이드',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
      ],
    );
  }

}

