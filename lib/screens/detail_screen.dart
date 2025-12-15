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

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _pageAnimationController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.candi.isFavorite;
    _pageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    )..forward();
    _fadeIn = CurvedAnimation(
      parent: _pageAnimationController,
      curve: Curves.easeOut,
    );
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _pageAnimationController, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeIn,
        child: SlideTransition(
          position: _slideIn,
          child: SingleChildScrollView(
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    super.dispose();
  }
  Future<bool> _ensureSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final signedIn = prefs.getBool('isSignedIn') ?? false;

    if (signedIn) return true;

    if (!mounted) return false;

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Perlu Sign In'),
        content: const Text(
          'Silakan sign in atau sign up terlebih dahulu untuk menambahkan favorit.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Nanti'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/signin');
            },
            child: const Text('Sign In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );

    return false;
  }

  // Favorite handler
  void toggleFavorite() async {
    final canProceed = await _ensureSignedIn();
    if (!canProceed) return;

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
