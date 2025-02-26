import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/admin/home/prize_giving_ceremony_controller.dart'; // Import the controller
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HighLightSlider extends StatefulWidget {
  const HighLightSlider({super.key});

  @override
  State<HighLightSlider> createState() => _HighLightSliderState();
}

class _HighLightSliderState extends State<HighLightSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final PrizeGivingCeremonyController _controller =
      Get.put(PrizeGivingCeremonyController()); // Initialize the controller

  @override
  void initState() {
    super.initState();
    // Fetch ceremonies when the widget is initialized
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

        return CarouselSlider(
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
          items: controller.ceremonies.map((ceremony) {
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
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: Text(
                          ceremony.prizeGivingCeremonyName,
                          style: GoogleFonts.sourceSerif4(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 215, top: 13),
                        child: Text(
                          ceremony.prizeGivingDate,
                          style: GoogleFonts.sourceSerif4(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 7,
                          ),
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
                            child: Image.network(
                              ceremony.prizeGivingImage,
                              height: 255,
                              width: 260,
                              fit: BoxFit.fitWidth,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child:
                                        Icon(Icons.error, color: Colors.red));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
