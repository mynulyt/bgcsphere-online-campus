import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SetImages extends StatefulWidget {
  const SetImages({super.key});

  @override
  State<SetImages> createState() => _SetImagesState();
}

class _SetImagesState extends State<SetImages> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 152,
          child: PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              Image.asset("images/bgc.png", width: 247, height: 152),
              Image.asset("images/bgc1.png", width: 247, height: 152),
              Image.asset("images/bgc2.png", width: 247, height: 152),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _controller,
          count: 4,
          effect: ExpandingDotsEffect(
            activeDotColor: const Color(0xffA4A1E6).withOpacity(0.15),
            dotColor: Colors.grey.shade300,
            dotHeight: 3.58,
            dotWidth: 3.58,
            expansionFactor: 2,
            spacing: 5,
          ),
        ),
      ],
    );
  }
}
