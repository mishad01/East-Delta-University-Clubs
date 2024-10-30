import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_clubs_app/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
    "assets/images/h2.png",
    "assets/images/h1.jpg",
    "assets/images/h3.png",
    "assets/images/h2.png",
    "assets/images/h1.jpg",
    "assets/images/h3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeFactor: 0.4,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            height: 320.0,
            viewportFraction: 0.75,
            onPageChanged: (index, reason) {
              _selectedIndex.value = index;
            },
          ),
          items: images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        AssetsPath.card,
                        width: 300,
                        height: 320,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 10),
                        child: Text(
                          "Prize Giving \nCeremony",
                          style: GoogleFonts.sourceSerif4(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 212, top: 10),
                        child: Text(
                          "14th November",
                          style: GoogleFonts.sourceSerif4(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8),
                        ),
                      ),
                      Positioned(
                        top: 57,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(21),
                            child: Image.asset(
                              i,
                              height: 255,
                              width: 260,
                              fit: BoxFit.fitWidth,
                            ),
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
        SizedBox(height: 2.h),
        Text(
          "Activates & Achievements",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, value, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < images.length; i++)
                      GestureDetector(
                        onTap: () async {
                          _selectedIndex.value = i; // Update the selected index
                          await Future.delayed(
                              Duration(milliseconds: 100)); // Small delay
                          _carouselController
                              .animateToPage(i); // Change carousel page
                        },
                        child: Container(
                          height: value == i ? 110 : 94,
                          width: value == i ? 110 : 94,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: value == i
                                ? Color(0xffD6D0FE)
                                : Color(0xffFEECBA),
                          ),
                          child: Center(
                            child: Text(
                              "Wildlife \nphotography",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: value == i ? 12 : 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget buildContainer(String i) {
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
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Container(
                    width: 85,
                    height: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: Color(0xff2D342F),
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
  }
}
