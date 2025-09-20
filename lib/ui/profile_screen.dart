import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'add_screen.dart';
import 'home_screen.dart'; // 🔹 Logout uchun HomePagega qaytish

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Box userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('userBox');
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = userBox.get('isLoggedIn', defaultValue: false);
    final String? username = userBox.get('name'); // 🔹 oldingi "username" emas
    final String? familya = userBox.get('surname'); // 🔹 oldingi "familya" emas
    final String? phone = userBox.get('phone');
    final String? email = userBox.get('email');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: isLoggedIn
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: Image.asset(
                        "assets/profile.png",
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    username ?? "Foydalanuvchi",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 2),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text("Ism: ${username ?? ''}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: Text("Familya: ${familya ?? ''}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text("Telefon: ${phone ?? ''}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Text("Email: ${email ?? ''}"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // 🔹 Logout tugmasi
                  TextButton(
                    onPressed: () async {
                      await userBox.clear(); // 🔹 Hive tozalanadi
                      if (!mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage("assets/profile.png"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      // 🔹 `await` bilan kutib turamiz va keyin setState
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddScreen()),
                      );
                      setState(() {});
                    },
                    child: const Text(
                      "Kirish",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1),
                ],
              ),
      ),
    );
  }
}
