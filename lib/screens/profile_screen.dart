import 'package:flutter/material.dart';
import '/widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = true;
  String fullName = "";
  String userName = "";
  int favoriteCandiCount = 0;

  void toggleSignIn() {
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }
  void signIn() => toggleSignIn();
  void signOut() => toggleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('images/placeholder_image.png'),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt),
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                const Divider(color: Colors.grey),
                const SizedBox(height: 4),

                ProfileInfoItem(
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  icon: Icons.lock,
                  label: 'Pengguna',
                  value: fullName,
                  showEditIcon: false,
                  onEditPressed: null,
                  iconColor: Colors.amber,
                ),
                const SizedBox(height: 4),
                const Divider(color: Colors.grey),
                const SizedBox(height: 4),
                
                ProfileInfoItem(
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  icon: Icons.person,
                  label: 'Nama',
                  value: userName,
                  showEditIcon: isSignedIn,
                  onEditPressed: isSignedIn ? () {} : null,
                  iconColor: Colors.deepPurple,
                ),
                const SizedBox(height: 4),
                const Divider(color: Colors.grey),
                const SizedBox(height: 4),

                ProfileInfoItem(
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  icon: Icons.favorite,
                  label: 'Favorit',
                  value: favoriteCandiCount == 0
                      ? '-'
                      : '$favoriteCandiCount favorites',
                  showEditIcon: false,
                  onEditPressed: null,
                  iconColor: Colors.redAccent,
                ),

                const SizedBox(height: 4),
                const Divider(color: Colors.grey),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: isSignedIn ? signOut : signIn,
                  child: Text(isSignedIn ? 'Sign Out' : 'Sign In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}