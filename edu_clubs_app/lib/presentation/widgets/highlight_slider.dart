import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_clubs_app/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        enlargeFactor: 0.4,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        height: 320.0,
        viewportFraction: 0.75,
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            //return buildContainer(i);
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
                    padding: const EdgeInsets.only(left: 215, top: 13),
                    child: Text(
                      "14th November",
                      style: GoogleFonts.sourceSerif4(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 7),
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
    );
  }

  Container buildContainer(String i) {
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
                      color: Color(0xff2D342F), // Inner container color
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
