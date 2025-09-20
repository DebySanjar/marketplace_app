import 'dart:async';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _banners = [
    "assets/banner.png",
    "assets/banner2.png",
    "assets/banner.png",
    "assets/banner3.png",
  ];

  @override
  @override
  void initState() {
    super.initState();
    _currentPage = 1; // ikkinchi bannerdan boshlash
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.9,
    );

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _banners.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            // bannerlar orasida margin
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(_banners[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
