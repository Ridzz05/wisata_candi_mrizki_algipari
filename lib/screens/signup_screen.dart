import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  // TODO: 1. Deklarasikan variabel
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _obscurePassword = true;
  late AnimationController _entranceController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();

    _fadeIn = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entranceController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // TODO: 10. Membuat metode _signUp
  void _signUp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = _nameController.text.trim();
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // Validasi input kosong
    if (name.isEmpty || username.isEmpty || password.isEmpty) {
      setState(() {
        _errorText = 'Nama, username, dan password wajib diisi';
      });
      return;
    }

    // Validasi kompleksitas password: minimal 8 karakter, kombinasi huruf dan angka (boleh huruf besar/kecil), tanpa syarat simbol
    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Za-z]')) ||
        !password.contains(RegExp(r'[0-9]'))) {
      setState(() {
        _errorText = 'Minimal 8 karakter, gunakan huruf dan angka (bebas besar/kecil)';
      });
      return;
    }

    try {
      // Gunakan key & iv acak lalu simpan agar bisa dipakai saat sign in
      final encrypt.Key key = encrypt.Key.fromSecureRandom(32);
      final iv = encrypt.IV.fromSecureRandom(16);

      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final encryptedName = encrypter.encrypt(name, iv: iv);
      final encryptedUsername = encrypter.encrypt(username, iv: iv);
      final encryptedPassword = encrypter.encrypt(password, iv: iv);

      await prefs.setString('fullname', encryptedName.base64);
      await prefs.setString('username', encryptedUsername.base64);
      await prefs.setString('password', encryptedPassword.base64);
      await prefs.setString('key', key.base64);
      await prefs.setString('iv', iv.base64);
      await prefs.setBool('isSignedIn', false);

      setState(() {
        _errorText = '';
      });

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/signin');
      }
    } catch (e) {
      setState(() {
        _errorText = 'Gagal menyimpan akun: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 2. Pasang AppBar
      appBar: AppBar(title: const Text('Sign Up')),
      // TODO: 3. Pasang body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideIn,
                child: Form(
                  child: Column(
                    // TODO: 4. Atur mainAxisAlignment dan crossAxisAlignment
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // TODO: 5. Pasang TextFormField Nama Lengkap
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "Nama",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // TODO: 6. Pasang TextFormField Nama Pengguna
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: "Nama Pengguna",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      // TODO: 7. Pasang TextFormField Kata Sandi
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Kata Sandi",
                          errorText: _errorText.isNotEmpty ? _errorText : null,
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        obscureText: _obscurePassword,
                      ),
                      // TODO: 8. Pasang ElevatedButton Sign Up
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signUp,
                        child: const Text("Sign Up"),
                      ),
                      // TODO: 9. Pasang TextButton Sign In
                      const SizedBox(height: 10),
                      // TextButton(
                      //     onPressed: () {},
                      //     child: Text('Sudah punya akun? Masuk di sini.')
                      // ),
                      RichText(
                        text: TextSpan(
                          text: 'Sudah punya akun? ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.deepPurple,
                          ),
                          children: [
                            TextSpan(
                              text: 'Masuk di sini.',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/signin',
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
