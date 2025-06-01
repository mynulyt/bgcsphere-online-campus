import 'dart:async';
import 'package:flutter/material.dart';

class SetImages extends StatefulWidget {
  const SetImages({super.key});

  @override
  State<SetImages> createState() => _SetImagesState();
}

class _SetImagesState extends State<SetImages> {
  final List<String> images = [
    "images/bgc.png",
    "images/bgc1.png",
    "images/bgc2.png",
    "images/culture.jpg",
  ];

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentIndex = (_currentIndex + 1) % images.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _nextImage() {
    _currentIndex = (_currentIndex + 1) % images.length;
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _prevImage() {
    _currentIndex = (_currentIndex - 1 + images.length) % images.length;
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _prevImage,
                icon: const Icon(Icons.arrow_back),
              ),
              Text("${_currentIndex + 1} / ${images.length}"),
              IconButton(
                onPressed: _nextImage,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          )
        ],
      ),
    );
  }
}
