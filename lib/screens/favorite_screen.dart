import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/data/candi_data.dart';
import '/models/candi.dart';
import '/screens/detail_screen.dart';
import '/widgets/item_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  List<Candi> _favoriteCandis = [];
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    _loadFavorites();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Fungsi untuk memuat data favorit dari SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNames = prefs.getStringList('favoriteCandiNames') ?? [];

    setState(() {
      _favoriteCandis = candiList
          .where((candi) => favoriteNames.contains(candi.name))
          .toList();
    });
  }

  // Fungsi untuk menghapus favorit
  Future<void> _removeFavorite(Candi candi) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNames = prefs.getStringList('favoriteCandiNames') ?? [];

    favoriteNames.remove(candi.name);
    await prefs.setStringList('favoriteCandiNames', favoriteNames);

    // Update state untuk menghapus dari list
    setState(() {
      _favoriteCandis.removeWhere((item) => item.name == candi.name);
    });

    // Update status favorit di model
    candi.isFavorite = false;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${candi.name} dihapus dari favorit')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit Saya'), centerTitle: true),
      body: _favoriteCandis.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.elasticOut,
                      ),
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.deepPurple[200],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada favorit',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple[300],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tambahkan candi ke favorit dari detail screen',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.deepPurple[200],
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _favoriteCandis.length,
              itemBuilder: (context, index) {
                final Candi candi = _favoriteCandis[index];
                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          (index / _favoriteCandis.length),
                          ((index + 1) / _favoriteCandis.length),
                          curve: Curves.easeOut,
                        ),
                      ),
                    );
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: Stack(
                      children: [
                        ItemCard(
                          candi: candi,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(candi: candi),
                              ),
                            ).then((_) {
                              // Refresh ketika kembali dari detail screen
                              _loadFavorites();
                            });
                          },
                        ),
                        // Tombol hapus favorit
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => _removeFavorite(candi),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
