import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // ✅ telefon uchun

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _countryCode = "+998"; // default Uzbekistan

  void _saveUser() async {
    final box = Hive.box('userBox');
    await box.put('isLoggedIn', true);
    await box.put('name', _nameController.text.trim());
    await box.put('surname', _surnameController.text.trim());
    await box.put('phone', '$_countryCode${_phoneController.text.trim()}');
    await box.put('email', _emailController.text.trim());

    Navigator.pop(context); // ProfileScreen ga qaytadi
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white , fontSize: 18),
        title:  Text("Foydalanuvchi qo'shish"),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Ism
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Ism",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Familya
            TextField(
              controller: _surnameController,
              decoration: const InputDecoration(
                labelText: "Familya",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Telefon raqam (country code bilan)
            IntlPhoneField(
              initialCountryCode: 'UZ',
              decoration: const InputDecoration(
                labelText: "Telefon raqam",
                border: OutlineInputBorder(),
              ),
              onChanged: (phone) {
                _countryCode = phone.countryCode;
                _phoneController.text = phone.number;
              },
            ),
            const SizedBox(height: 16),

            // Gmail
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Saqlash tugmasi
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 🔹 12 px radius
                ),
              ),
              onPressed: _saveUser,
              child: const Text("Saqlash" , style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
