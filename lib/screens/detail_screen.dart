import 'package:flutter/material.dart';
import 'package:wisata_candi_mrizki_algipari/models/candi.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.candi});

  final Candi candi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(candi.name)),
      body: Column(
        children: [Image.asset(candi.imageAsset), Text(candi.description)],
      ),
    );
  }
}
