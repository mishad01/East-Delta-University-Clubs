import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClubDetailsSlider extends StatefulWidget {
  const ClubDetailsSlider({super.key});

  @override
  State<ClubDetailsSlider> createState() => _ClubDetailsSliderState();
}

class _ClubDetailsSliderState extends State<ClubDetailsSlider> {
  ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();

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
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 320.0,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                onPageChanged: (index, reason) {
                  _selectedIndex.value = index;
                },
              ),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      height: 286,
                      child: SvgPicture.asset(
                        "assets/images/card.svg",
                        height: 286,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Text(
              "Activities & Achievements",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < images.length; i++)
                      GestureDetector(
                        onTap: () {
                          _selectedIndex.value = i;
                          _carouselController.jumpToPage(_selectedIndex.value);
                          setState(() {});
                        },
                        child: Container(
                          height: 13,
                          width: 13,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: _selectedIndex.value == i
                                ? Colors.white
                                : Colors.amberAccent.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.5)),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Create a new screen to navigate to
class NextScreen extends StatelessWidget {
  final int imageIndex;

  const NextScreen({Key? key, required this.imageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Details")),
      body: Center(
        child: Text("Details for Image Index: $imageIndex"),
      ),
    );
  }
}
