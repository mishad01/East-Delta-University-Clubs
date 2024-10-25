import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HighLightSlider extends StatefulWidget {
  const HighLightSlider({
    super.key,
  });

  @override
  State<HighLightSlider> createState() => _HighLightSliderState();
}

class _HighLightSliderState extends State<HighLightSlider> {
  ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  final List<String> images = [
    "assets/images/h1.jpg",
    "assets/images/2.png",
    "assets/images/3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 286.0),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(13)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 2,
                            bottom: 2,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 237,
                              width: 229,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(21)),
                              child: Image.asset(
                                i,
                                width: 229,
                                height: 237,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
