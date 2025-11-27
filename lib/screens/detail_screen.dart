import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/candi.dart';
import '/widgets/detail_gallery.dart';
import '/widgets/detail_header.dart';
import '/widgets/detail_info.dart';

class DetailScreen extends StatefulWidget {
  final Candi candi;

  const DetailScreen({super.key, required this.candi});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.candi.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeader(
              imageUrl: widget.candi.imageUrls.first,
              candiName: widget.candi.name,

              // sesuai instruksi materi: tombol back menggunakan onTap → Navigator.pop
              onBackPressed: () {
                Navigator.pop(context);
              },
            ),

            DetailInfo(
              candi: widget.candi,
              isFavorite: isFavorite,
              onToggleFavorite: toggleFavorite,
            ),

            DetailGallery(imageUrls: widget.candi.imageUrls),
          ],
        ),
      ),
    );
  }
  // Favorite handler
  void toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isFavorite = !isFavorite;
      widget.candi.isFavorite = isFavorite;
    });

    // Simpan ke SharedPreferences
    final favoriteNames = prefs.getStringList('favoriteCandiNames') ?? [];

    if (isFavorite) {
      if (!favoriteNames.contains(widget.candi.name)) {
        favoriteNames.add(widget.candi.name);
      }
    } else {
      favoriteNames.remove(widget.candi.name);
    }

    await prefs.setStringList('favoriteCandiNames', favoriteNames);
  }
}
