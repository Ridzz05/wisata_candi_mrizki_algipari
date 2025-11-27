import 'package:flutter/material.dart';

class DetailHeader extends StatelessWidget {
  final String imageUrl;
  final String candiName;
  final VoidCallback onBackPressed;

  const DetailHeader({
    super.key,
    required this.imageUrl,
    required this.candiName,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'candi-$candiName',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
        ),

        // Tombol back custom sesuai materi InkWell onTap
        Positioned(
          top: 40,
          left: 20,
          child: Material(
            color: Colors.white70,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onBackPressed,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.deepPurple,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
