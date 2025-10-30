// screens/detail_screen.dart
import 'package:flutter/material.dart';
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
              onBackPressed: () => Navigator.pop(context),
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

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      widget.candi.isFavorite = isFavorite;
    });
  }
}
