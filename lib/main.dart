import 'package:flutter/material.dart';
import '/screens/signin_screen.dart';

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
      home: SignInScreen(),
      // home: ProfileScreen(),
      // home : DetailScreen(candi: candi, candilist[0],)
    );
  }
}
