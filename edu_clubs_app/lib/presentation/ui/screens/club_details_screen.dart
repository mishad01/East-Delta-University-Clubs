import 'package:edu_clubs_app/presentation/utility/assets_path.dart';
import 'package:edu_clubs_app/presentation/widgets/club_details_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class ClubDetailsScreen extends StatefulWidget {
  const ClubDetailsScreen({super.key});

  @override
  State<ClubDetailsScreen> createState() => _ClubDetailsScreenState();
}

class _ClubDetailsScreenState extends State<ClubDetailsScreen> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Photography Club",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 2.h),
              const ClubDetailsSlider(),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What We Do",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        "Being part of this club has been an incredible journey of growth,teamwork, and unforgettable experiencesBeing part of this club has been an incredible journey of growth,teamwork, and unforgettable experiences"),
                    SizedBox(height: 2.h),
                    const Text(
                      "Why Join Us",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              AssetsPath.join_us_card,
                            ),
                          ),
                          Positioned(
                            left: 40,
                            right: 40,
                            top: 120,
                            child: Text(
                              "Being part of this club has been an incredible journey of growth,teamwork, and unforgettable Being part of this club has been an incredible journey of growth, Being part of this club has been an Being part of this club has been an incredible journey of growth,teamwork, and unforgettable",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Positioned(
                            left: 140,
                            right: 40,
                            top: 200,
                            child: Text(
                              "Being part of this club has been an incredible journey of growth,teamwork, and unforgettable Being part of this club has been an incredible journey of growth, Being part of this club has been an Being part of this club has been an incredible journey of growth,teamwork, and unforgettable",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              // textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      child: Center(
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              AssetsPath.news_card,
                              height: 350,
                              width: double.infinity,
                            ),
                            Positioned(
                              top: 28,
                              left: 45,
                              child: Column(
                                children: [
                                  Text(
                                    "Recent\nOpenings",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 45,
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 100,
                                    child: Text(
                                      "Being part of this club has bteamwork, and unforgettable experiences",
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 140,
                              left: 250,
                              child: Column(
                                children: [
                                  Text(
                                    "Upcoming\nActivites",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              right: 10,
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 100,
                                    child: Text(
                                      "Being part of this club has bteamwork, and unforgettable experiences",
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "FAQ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        height: 1.0,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(right: 20),
                      itemBuilder: (context, index) {
                        return Card(
                          shadowColor: Colors.blue,
                          color: Color(0xffD2D8D4),
                          child: Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              trailing: Icon(Icons.more_vert_rounded),
                              title: Text(
                                "What does our members do?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, bottom: 8),
                                  child: Text(
                                    "Being part of this club has been an incredible journey of growth. Being part of this club has been an incredible journey of growth. Being part of this club has been an incredible journey of growth.",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
