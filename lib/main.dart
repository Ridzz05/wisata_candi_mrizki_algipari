import 'package:flutter/material.dart';
import 'package:wisata_candi_mrizki_algipari/data/candi_data.dart';
import 'package:wisata_candi_mrizki_algipari/screens/detail_screen.dart';
import 'package:wisata_candi_mrizki_algipari/models/candi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
