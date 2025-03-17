import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/utils/image_card.dart';
import 'package:edu_clubs_app/view_model/admin/home/prize_giving_ceremony_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HighLightSlider extends StatefulWidget {
  const HighLightSlider({super.key});

  @override
  State<HighLightSlider> createState() => _HighLightSliderState();
}

class _HighLightSliderState extends State<HighLightSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final PrizeGivingCeremonyController _controller =
      Get.put(PrizeGivingCeremonyController());

  @override
  void initState() {
    super.initState();
    _controller.fetchCeremonies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrizeGivingCeremonyController>(
      builder: (controller) {
        if (controller.isUploading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.ceremonies.isEmpty) {
          return const Center(child: Text("No ceremonies found."));
        }

        double viewportFraction =
            MediaQuery.of(context).size.width > 600 ? 0.85 : 0.80;

        return SizedBox(
          width: 350, // Ensuring consistent width
          child: CarouselSlider(
            options: CarouselOptions(
              height: 270,
              viewportFraction: viewportFraction,
              enlargeCenterPage: true,
              enlargeFactor: 0.3, // Adjust to control spacing
              clipBehavior: Clip.none, // Prevents clipping issues
              onPageChanged: (index, reason) {
                _selectedIndex.value = index;
              },
            ),
            items: controller.ceremonies.map((ceremony) {
              return EventImageCard(
                prizeGivingDate: ceremony.prizeGivingDate,
                prizeGivingImage: ceremony.prizeGivingImage,
                eventTitle: ceremony.prizeGivingCeremonyName,
              );
              return Container(
                width: 238,
                height: 270,
                color: Colors.black,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
