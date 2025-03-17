import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_clubs_app/resources/assets_path.dart';
import 'package:edu_clubs_app/utils/image_card.dart';
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
  });
  final String clubDetailsId;

  @override
  State<ClubEventsSlider> createState() => _ClubEventsSliderState();
}

class _ClubEventsSliderState extends State<ClubEventsSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final ClubEventController _eventController = Get.put(ClubEventController());

  @override
  void initState() {
    super.initState();
    // Fetch events based on the provided clubDetailsId
    _eventController.fetchEvents(widget.clubDetailsId);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _buildCarouselSlider(),
          _buildSectionTitle(),
          SizedBox(height: .8.h),
          _buildIndicatorRow(),
        ],
      ),
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
        double viewportFraction =
            MediaQuery.of(context).size.width > 600 ? 0.95 : 0.80;
        return SizedBox(
            width: 350, // Ensuring consistent width
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 270,
                //viewportFraction: viewportFraction,
                enlargeCenterPage: true,
                enlargeFactor: 0.3, // Adjust to control spacing
                clipBehavior: Clip.none, // Prevents clipping issues
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
                final sessionDate = event['session_date'] ??
                    'No Date'; // Provide a fallback date

                return EventImageCard(
                    prizeGivingDate: sessionDate,
                    prizeGivingImage: sessionImage,
                    eventTitle: sessionName);
              }).toList(),
            ));
      },
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
