import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/pages/home_screen.dart';
import 'package:notes_app_firebase/services/database_service.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFFE9E9E9),
    statusBarColor: Color(0xFFE9E9E9),
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE9E9E9),
        primarySwatch: Colors.orange,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.5,
          backgroundColor: Color(0xFFE9E9E9),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF2C384A),
        primarySwatch: Colors.orange,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Color(0xFF2C384A),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.5,
          backgroundColor: Color(0xFF2C384A),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
