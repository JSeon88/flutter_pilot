import 'package:flutter/material.dart';
import 'package:flutter_pilot/provider/guide_provider.dart';
import 'package:flutter_pilot/repository/guide_repository.dart';
import 'package:flutter_pilot/screen/root_screen.dart';
import 'package:provider/provider.dart';

void main() {
  final repository = GuideRepository();
  final guideProvider = GuideProvider(repository: repository);

  runApp(
    ChangeNotifierProvider(
      create: (_) => guideProvider,
      child: MaterialApp (
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey[600],
          ),
        ),
        home: const RootScreen()
      )
    )
  );
}


