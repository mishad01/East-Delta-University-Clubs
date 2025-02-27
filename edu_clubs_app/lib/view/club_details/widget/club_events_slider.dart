import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_clubs_app/resources/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:edu_clubs_app/view_model/club_events/club_event_controller.dart';
import 'package:sizer/sizer.dart'; // Import your event controller

class ClubEventsSlider extends StatefulWidget {
  const ClubEventsSlider({
    super.key,
    required this.clubDetailsId,
  }); // Change parameter name to clubDetailsId
  final String clubDetailsId; // Use clubDetailsId instead of CategoryId

  @override
  State<ClubEventsSlider> createState() => _ClubEventsSliderState();
}

class _ClubEventsSliderState extends State<ClubEventsSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final ClubEventController _eventController =
      Get.put(ClubEventController()); // Initialize the event controller

  @override
  void initState() {
    super.initState();
    // Fetch events based on the provided clubDetailsId
    _eventController.fetchEvents(widget.clubDetailsId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        _buildSectionTitle(),
        SizedBox(height: .8.h),
        _buildIndicatorRow(),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return GetBuilder<ClubEventController>(
      builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.allEvents.isEmpty) {
          return const Center(child: Text("No events found."));
        }

        return CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeFactor: 0.4,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            height: 42.h,
            viewportFraction: 0.75,
            onPageChanged: (index, reason) {
              _selectedIndex.value = index;
            },
          ),
          items: controller.allEvents.map((event) {
            // Ensure that the event data is not null
            final sessionImage = event['session_images'] ??
                'https://via.placeholder.com/300'; // Provide a fallback image URL
            final sessionName = event['session_name'] ??
                'Unnamed Event'; // Provide a fallback name
            final sessionDate =
                event['session_date'] ?? 'No Date'; // Provide a fallback date

            return _buildCarouselItem(sessionImage, sessionName, sessionDate);
          }).toList(),
        );
      },
    );
  }

  Widget _buildCarouselItem(String image, String title, String date) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.card,
          width: 40.w,
          height: 36.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w, top: 1.2.h),
          child: SizedBox(
            width: 35.w, // You can adjust the width based on your layout
            child: Text(
              title,
              maxLines: 2, // This allows the text to wrap after 2 lines
              overflow: TextOverflow
                  .ellipsis, // Adds ellipsis if the text exceeds two lines
              style: GoogleFonts.sourceSerif4(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 55.w, top: 1.2.h),
          child: Text(
            date,
            style: GoogleFonts.sourceSerif4(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
        Positioned(
          top: 5.7.h,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: Image.network(
                image,
                height: 29.h,
                width: 65.w,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                      child: Icon(Icons.error, color: Colors.red));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Text(
      "Activities & Achievements",
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildIndicatorRow() {
    return GetBuilder<ClubEventController>(
      builder: (controller) {
        if (controller.inProgress || controller.allEvents.isEmpty) {
          return const SizedBox
              .shrink(); // Hide indicators if no events are available
        }

        return ValueListenableBuilder<int>(
          valueListenable: _selectedIndex,
          builder: (context, value, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.allEvents.length, (index) {
                    return _buildIndicatorItem(index, value,
                        controller.allEvents[index]['session_name']);
                  }),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIndicatorItem(int index, int selectedIndex, String title) {
    return GestureDetector(
      onTap: () async {
        _selectedIndex.value = index;
        await Future.delayed(const Duration(milliseconds: 100));
        _carouselController.animateToPage(index);
      },
      child: Container(
        height: selectedIndex == index ? 110 : 94,
        width: selectedIndex == index ? 110 : 94,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: selectedIndex == index ? Color(0xffD6D0FE) : Color(0xffFEECBA),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: selectedIndex == index ? 12 : 10,
            ),
          ),
        ),
      ),
    );
  }
}
