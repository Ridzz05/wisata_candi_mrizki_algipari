// widgets/detail_info.dart
import 'package:flutter/material.dart';
import '/models/candi.dart';

class DetailInfo extends StatelessWidget {
  final Candi candi;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const DetailInfo({
    super.key,
    required this.candi,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(candi.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.redAccent,
                ),
                onPressed: onToggleFavorite,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.location_on, size: 18, color: Colors.amber),
            const SizedBox(width: 6),
            Text(candi.location),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.calendar_month, size: 18, color: Colors.blue,),
            const SizedBox(width: 6),
            Text('Dibangun: ${candi.built}'),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.house, size: 18, color: Colors.pink,),
            const SizedBox(width: 6),
            Text('Tipe: ${candi.type}'),
          ]),
          const SizedBox(height: 16),
          Divider(color: Colors.deepPurple.shade100),
          const SizedBox(height: 8),
          const Text(
            'Deskripsi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(candi.description, textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}
