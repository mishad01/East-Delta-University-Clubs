import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_clubs_app/view/web/web_view.dart';
import 'package:edu_clubs_app/view_model/admin/home/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.w)),
        child: Column(
          children: [
            GetBuilder<BannerController>(
              builder: (controller) {
                if (controller.banners.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: [
                    _buildCarousel(controller),
                    SizedBox(height: 1.h),
                    _buildIndicator(controller),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the carousel slider
  Widget _buildCarousel(BannerController controller) {
    return CarouselSlider.builder(
      itemCount: controller.banners.length,
      options: CarouselOptions(
        viewportFraction: 2,
        height: 27.h,
        onPageChanged: (index, reason) {
          setState(() {
            activeIndex = index; // Update the active index
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final banner = controller.banners[index];
        return InkWell(
          onTap: () {
            Get.to(() => WebView(
                link:
                    "https://docs.google.com/forms/d/e/1FAIpQLScuXOHiC899P09-hdrJO3QfV87FSyeObRk7rjquHFVahqjMDg/viewform?usp=sharing"));
          },
          child: _buildBannerItem(banner.bannerImage),
        );
      },
    );
  }

  /// Builds a single banner item
  Widget _buildBannerItem(String imageUrl) {
    return Column(
      children: [
        SizedBox(height: 1.h),
        Stack(
          children: [
            SizedBox(
              height: 25.h,
              width: 93.w,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Icon(Icons.broken_image, size: 50));
                  },
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: 4.h,
                width: 20.w,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "Current \nActivities",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the indicator dots
  Widget _buildIndicator(BannerController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.banners.length,
        (i) => Container(
          height: 1.5.h,
          width: 1.5.h,
          margin: EdgeInsets.only(right: 1.w),
          decoration: BoxDecoration(
            color: i == activeIndex
                ? Colors.amberAccent
                    .withOpacity(0.8) // Change color based on activeIndex
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(2.w),
          ),
        ),
      ),
    );
  }
}
