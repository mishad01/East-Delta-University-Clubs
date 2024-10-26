import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighLightSlider extends StatefulWidget {
  const HighLightSlider({super.key});

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
              options: CarouselOptions(
                height: 320.0,
                viewportFraction: 0.8,
              ),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      height: 286,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Color(0xff2D342F),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Prize Giving \nCeremony",
                                  style: GoogleFonts.sourceSerif4(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(23),
                                  ),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 85,
                                    height: 33,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(23),
                                      color: Color(
                                          0xff2D342F), // Inner container color
                                    ),
                                    child: Center(
                                      child: Text(
                                        "14th November, 2023",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 270,
                            height: 237,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(21),
                              child: Image.asset(
                                i,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}