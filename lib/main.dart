import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '/screens/search_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/favorite_screen.dart';
import '/screens/signin_screen.dart';
import '/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MainScreen(),
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signinscreen': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  /// Fungsi untuk merender screen berdasarkan index yang dipilih dari bottomnav
  Widget _renderScreen() {
    switch (_currentIndex) {
      case 0:
        // Home Screen
        return const HomeScreen();
      case 1:
        // Search Screen
        return const SearchScreen();
      case 2:
        // Profile Screen
        return const FavoriteScreen();
      // Favorite Screen
      case 3:
        return const ProfileScreen();
      default:
        // Default ke Home Screen
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _renderScreen(),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.deepPurple[50]),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.deepPurple[200],
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorit",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
