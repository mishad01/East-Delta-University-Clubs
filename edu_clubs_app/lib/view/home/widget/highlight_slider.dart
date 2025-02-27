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

        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeFactor: 0.4,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            height: 40.h,
            viewportFraction: 0.83,
            onPageChanged: (index, reason) {
              _selectedIndex.value = index;
            },
          ),
          items: controller.ceremonies.map((ceremony) {
            return Builder(
              builder: (BuildContext context) {
                /*return Container(
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        AssetsPath.card,
                        width: 80.w,
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, top: .8.h),
                        child: Text(
                          "Prize giving\nCeremony",
                          style: GoogleFonts.sourceSerif4(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 60.w, top: .5.h),
                        child: Text(
                          ceremony.prizeGivingDate,
                          style: GoogleFonts.sourceSerif4(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 7.h,
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
                              height: 32.h,
                              width: 72.w,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );*/
                return EventImageCard(
                  prizeGivingDate: ceremony.prizeGivingDate,
                  prizeGivingImage: ceremony.prizeGivingImage,
                  eventTitle: ceremony.prizeGivingCeremonyName,
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
