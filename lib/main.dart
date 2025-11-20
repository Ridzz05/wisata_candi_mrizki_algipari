import 'package:flutter/material.dart';
import '/screens/search_screen.dart';
import '/data/candi_data.dart';
import '/screens/detail_screen.dart';
import '/screens/signin_screen.dart';
import '/screens/search_screen.dart';
import '/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wisata Candi',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // home: HomeScreen(),
      // home: ProfileScreen(),
      // home: DetailScreen(candi: candi),\
      // home: ListScreen(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // TODO
    );
  } 
}