import 'package:edu_clubs_app/presentation/utility/assets_path.dart';
import 'package:edu_clubs_app/presentation/widgets/club_details_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClubDetailsScreen extends StatefulWidget {
  const ClubDetailsScreen({super.key});

  @override
  State<ClubDetailsScreen> createState() => _ClubDetailsScreenState();
}

class _ClubDetailsScreenState extends State<ClubDetailsScreen> {
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
                padding: const EdgeInsets.only(left: 20),
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
                            left: 120,
                            right: 40,
                            top: 200,
                            child: Text(
                              "Being part of this club has been an incredible journey of growth,teamwork, and unforgettable Being part of this club has been an incredible journey of growth, Being part of this club has been an Being part of this club has been an incredible journey of growth,teamwork, and unforgettable",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
