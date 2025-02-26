import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_clubs_app/view_model/admin/home/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final BannerController bannerController = Get.find<BannerController>();
  int activeIndex = 0; // Track the active index

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            GetBuilder<BannerController>(
              builder: (bannerController) {
                if (bannerController.banners.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 230.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index; // Update the active index
                      });
                    },
                  ),
                  items: bannerController.banners.map((banner) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            Stack(
                              children: [
                                Container(
                                  height: 212,
                                  width: 368,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    banner.bannerImage,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                          child: Icon(Icons.broken_image,
                                              size: 50));
                                    },
                                  ),
                                ),
                                Container(
                                  height: 27,
                                  width: 71,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Current \nActivities",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 10),
            GetBuilder<BannerController>(
              builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.banners.length,
                    (i) => Container(
                      height: 13,
                      width: 13,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: i == activeIndex
                            ? Colors.white // Change color based on activeIndex
                            : Colors.amberAccent.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
