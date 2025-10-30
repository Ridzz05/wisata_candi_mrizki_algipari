import 'package:flutter/material.dart';
import 'package:wisata_candi_mrizki_algipari/widgets/profile_info_item.dart'; // step for refactoring

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = true;
  String fullName = "M. Rizki Algipari";
  String userName = "ridzz_05";
  int favoriteCandiCount = 0;

  void signIn() {
    setState(() => isSignedIn = true);
  }

  void signOut() {
    setState(() => isSignedIn = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color band
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),

          // Content
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
                            onPressed: () {}, // TODO: open bottom sheet later
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

                // Profile info
                ProfileInfoItem(
                  icon: Icons.lock,
                  label: "Pengguna",
                  value: fullName,
                  showEditIcon: isSignedIn,
                  onEditPressed: () {}, // TODO: edit name
                  iconColor: Colors.amber,
                ),
                const SizedBox(height: 4),
                const Divider(color: Colors.grey),
                const SizedBox(height: 4),
                ProfileInfoItem(
                  icon: Icons.person,
                  label: "Nama",
                  value: userName,
                  showEditIcon: isSignedIn,
                  onEditPressed: () {},
                  iconColor: Colors.deepPurple,
                ),
                const SizedBox(height: 4),
                const Divider(color: Colors.grey),
                const SizedBox(height: 4),
                ProfileInfoItem(
                  icon: Icons.favorite,
                  label: "Favorite",
                  value: favoriteCandiCount == 0
                      ? "-"
                      : "$favoriteCandiCount favorites",
                  showEditIcon: false,
                  iconColor: Colors.redAccent,
                ),

                const SizedBox(height: 20),
                const Divider(color: Colors.grey),

                // Action button
                TextButton(
                  onPressed: isSignedIn ? signOut : signIn,
                  child: Text(isSignedIn ? "Sign Out" : "Sign In"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
