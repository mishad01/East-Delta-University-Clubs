import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/club_details/club_details_view.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';
import 'package:flutter/material.dart';

class AllCategoriesGrid extends StatelessWidget {
  const AllCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // You can define a list of colors or gradients based on your requirement.
    final List<Color> categoryBackgrounds = [
      Colors.blue[50]!,
      Colors.green[50]!,
      Colors.red[50]!,
      Colors.orange[50]!,
      Colors.purple[50]!,
      Colors.yellow[50]!,
    ];

    return GetBuilder<ClubCategoriesController>(
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Clubs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.black87, // Black text for the title
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => AllClubView());
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors
                            .deepPurple, // Purple for the "See All" button
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 35.0.h,
                child: controller.inProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        itemCount: controller.clubCategories.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 3.w,
                          mainAxisSpacing: 3.w,
                        ),
                        itemBuilder: (context, index) {
                          final category = controller.clubCategories[index];

                          // Dynamically select the background color or gradient
                          Color backgroundColor = categoryBackgrounds[
                              index % categoryBackgrounds.length];

                          return InkWell(
                            onTap: () => Get.to(() => ClubDetailsView(
                                  categoriesId: category['id'],
                                )),
                            child: Card(
                              elevation: 3, // Subtle shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      backgroundColor,
                                      backgroundColor.withOpacity(0.8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ), // Light background
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 14.h,
                                      width: 30.w,
                                      child: Column(
                                        children: [
                                          Image.network(
                                            category['icon_img'],
                                            height: 10.5.h,
                                            width: 25.5.w,
                                            fit: BoxFit.contain,
                                          ),
                                          CustomText(
                                            text: category['club_name'],
                                            customStyle: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                              color:
                                                  Colors.black87, // Black text
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
