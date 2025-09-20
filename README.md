# Marketplace Flutter App

**Marketplace** - bu Flutter bilan yaratilgan birinchi mobil ilovam bo‘lib, foydalanuvchilarga mahsulotlarni ko‘rish, savatchaga qo‘shish va xarid qilish imkonini beradi. Ilova RestApi va **Hive** yordamida local data saqlaydi va `Like/Cart` funksiyasini taklif qiladi.  

---

## 📌 Xususiyatlari

- Mahsulotlar ro‘yxati va tafsilotlari (title, description, price, rating)
- Mahsulot rasmlari bilan **detail page**
- Savatcha (Cart) funksiyasi: qo‘shish, o‘chirish, saqlash
- Local database: **Hive** bilan offline saqlash

  ``` yaml
  
---

## ⚙️ Texnologiyalar

- Flutter & Dart
- Hive (local database)
- Provider (state management)
- HTTP / API service
- Material Design

---

## 🚀 O‘rnatish

1. Repository’ni klonlash:

```bash
git clone https://github.com/username/untitled1.git
cd untitled1

Dependency’larni o‘rnatish:

flutter pub get


Hive uchun adapterlarni generatsiya qilish (agar kerak bo‘lsa):

flutter packages pub run build_runner build --delete-conflicting-outputs


Ilovani ishga tushirish:

flutter run
```

