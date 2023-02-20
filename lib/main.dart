import 'package:flutter/material.dart';
import 'package:flutter_pilot/screen/root_screen.dart';

void main() {
  runApp(
      MaterialApp (
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey[600],
          ),
        ),
        home: const RootScreen()
      )
  );
}


