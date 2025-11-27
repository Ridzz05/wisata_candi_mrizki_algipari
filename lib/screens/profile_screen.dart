import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  // 1. Declare necessary variables
  bool isSignedIn = false;
  String fullName = ''; // Example name
  String userName = ''; // Example username
  int favoriteCandiCount = 0;
  String? profileImageBase64;

  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  //5. implementasi fungsi signIn
  void signIn() {
    Navigator.pushNamed(context, "/signinscreen");
  }

  //6. implementasi fungsi signOut
  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);

    setState(() {
      isSignedIn = !isSignedIn;
      userName = '';
      fullName = '';
      favoriteCandiCount = 0;
    });

    // Tampilkan snackbar konfirmasi
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Anda berhasil sign out')));
    }
  }

  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSignedIn = prefs.getBool("isSignedIn") ?? false;
    });
  }

  void _identitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString("fullname") ?? "";
      userName = prefs.getString("username") ?? "";
    });
  }

  // Fungsi untuk mendapatkan jumlah favorit
  Future<void> _getFavoriteCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteNames = prefs.getStringList('favoriteCandiNames') ?? [];
    setState(() {
      favoriteCandiCount = favoriteNames.length;
    });
  }

  // Fungsi untuk memilih gambar dari gallery dan upload ke SharedPreferences
  // - Buka image picker dari gallery
  // - Convert gambar ke bytes kemudian encode ke base64
  // - Simpan base64 string ke SharedPreferences dengan key 'profileImageBase64'
  // - Update state untuk menampilkan gambar di CircleAvatar
  // - Tampilkan SnackBar konfirmasi jika berhasil
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        // Baca file sebagai bytes
        final bytes = await pickedFile.readAsBytes();
        // Convert ke base64
        final base64String = base64Encode(bytes);

        // Simpan ke SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profileImageBase64', base64String);

        setState(() {
          profileImageBase64 = base64String;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Foto profil berhasil diperbarui')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  // Fungsi untuk memuat foto profil dari SharedPreferences
  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profileImageBase64 = prefs.getString('profileImageBase64');
    });
  }

  @override
  void initState() {
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeIn),
    );

    _fadeAnimationController.forward();

    // Load sign in status dan data
    _checkSignInStatus();
    _loadProfileImage();
    _identitas();
    _getFavoriteCount();

    super.initState();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.deepPurple,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.deepPurple,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.deepPurple[100],
                                backgroundImage: profileImageBase64 != null
                                    ? MemoryImage(
                                        base64Decode(profileImageBase64!),
                                      )
                                    : null,
                                child: profileImageBase64 == null
                                    ? Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.deepPurple,
                                      )
                                    : null,
                              ),
                            ),
                            // Camera button - positioned at bottom right corner
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.deepPurple,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.deepPurple[100]),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Row(
                            children: [
                              Icon(Icons.lock, color: Colors.amber),
                              SizedBox(width: 8),
                              Text(
                                'Pengguna',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ': $userName',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Divider(color: Colors.deepPurple[100]),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.blue),
                              SizedBox(width: 8),
                              Text(
                                'Nama',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ': $fullName',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Divider(color: Colors.deepPurple[100]),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Favorite',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ': $favoriteCandiCount',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    isSignedIn
                        ? TextButton(
                            onPressed: signOut,
                            child: const Text('Sign Out'),
                          )
                        : TextButton(
                            onPressed: signIn,
                            child: const Text('Sign In'),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
