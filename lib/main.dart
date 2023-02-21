import 'package:flutter/material.dart';
import 'package:flutter_pilot/screen/root_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

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


