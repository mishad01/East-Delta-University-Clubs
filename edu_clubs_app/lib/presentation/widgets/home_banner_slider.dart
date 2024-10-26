import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  final List<String> images = [
    "assets/images/bn1.png",
    "assets/images/bn2.png",
    "assets/images/bn3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                height: 230.0, // Updated height for the Carousel
                onPageChanged: (index, reason) {
                  _selectedIndex.value = index;
                },
              ),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        Stack(
                          children: [
                            Container(
                              height: 212, // Updated container height
                              width: 368, // Updated container width
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(
                                i,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 27,
                              width: 71,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Center(
                                child: Text(
                                  "Current \nActivites",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0;
                        i < images.length;
                        i++) // Updated to images.length
                      Container(
                        height: 13,
                        width: 13,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: _selectedIndex.value == i
                                ? Colors.white
                                : Colors.amberAccent.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5))),
                      )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
