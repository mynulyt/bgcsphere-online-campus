import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Auto-sliding swiper with 3 second interval
      VxSwiper.builder(
        itemCount: images.length,
        height: 152,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        itemBuilder: (context, index) {
          return Image.asset(
            images[index],
            width: 347,
            height: 152,
            fit: BoxFit.cover,
          ).box.roundedSM.clip(Clip.antiAlias).make();
        },
      ),
    ]);
  }
}
