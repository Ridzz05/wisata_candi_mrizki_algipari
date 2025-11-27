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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wisata Candi')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: candiList.length,
        itemBuilder: (context, index) {
          final Candi candi = candiList[index];
          final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                    (index / candiList.length),
                    ((index + 1) / candiList.length),
                    curve: Curves.easeOut,
                  ),
                ),
              );

          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: ItemCard(
                candi: candi,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(candi: candi),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
