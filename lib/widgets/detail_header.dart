import 'package:flutter/material.dart';

class DetailHeader extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onBackPressed;

  const DetailHeader({
    super.key,
    required this.imageUrl,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 40,
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white70,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
              onPressed: onBackPressed,
            ),
          ),
        ),
      ],
    );
  }
}
