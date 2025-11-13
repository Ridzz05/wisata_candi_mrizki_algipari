import 'package:flutter/material.dart';
import 'package:wisata_candi_mrizki_algipari/screens/search_screen.dart';

import '/data/candi_data.dart';
import '/screens/detail_screen.dart';
import '/screens/signin_screen.dart';
import '/screens/search_screen.dart';

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
      home: SearchScreen(),
      // home: ProfileScreen(),
      // home: DetailScreen(candi: candi),\
      // home: ListScreen(),
    );
  }
}
