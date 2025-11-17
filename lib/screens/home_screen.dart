import 'package:flutter/material.dart';

import '/data/candi_data.dart';
import '/models/candi.dart';
import '/screens/detail_screen.dart';
import '/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Candi'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: candiList.length,
        itemBuilder: (context, index) {
          final Candi candi = candiList[index];
          return ItemCard(
            candi: candi,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(candi: candi),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
