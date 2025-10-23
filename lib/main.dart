import 'package:flutter/material.dart';
import 'package:wisata_candi_mrizki_algipari/data/candi_data.dart';
import 'package:wisata_candi_mrizki_algipari/screens/detail_screen.dart';

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
      home: DetailScreen(candi: candiList[0]),
    );
  }
}
