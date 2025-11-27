// widgets/detail_info.dart
import 'package:flutter/material.dart';
import '/models/candi.dart';

class DetailInfo extends StatefulWidget {
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
  State<DetailInfo> createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _slideController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.candi.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ScaleTransition(
                    scale: _slideController,
                    child: IconButton(
                      icon: Icon(
                        widget.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                      onPressed: widget.onToggleFavorite,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 18, color: Colors.amber),
                  const SizedBox(width: 6),
                  Text(widget.candi.location),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 6),
                  Text('Dibangun: ${widget.candi.built}'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.house, size: 18, color: Colors.pink),
                  const SizedBox(width: 6),
                  Text('Tipe: ${widget.candi.type}'),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.deepPurple.shade100),
              const SizedBox(height: 8),
              const Text(
                'Deskripsi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(widget.candi.description, textAlign: TextAlign.justify),
            ],
          ),
        ),
      ),
    );
  }
}
