import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllCategoriesGrid extends StatelessWidget {
  const AllCategoriesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => AllClubView());
                    },
                    child: Text("See All"),
                  ),
                ],
              ),
            ),
            // Wrap GridView.builder in a Container or Expanded widget
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 300, // Set a fixed height for the grid view
                child: controller.inProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      ) // Loading indicator while fetching
                    : GridView.builder(
                        itemCount: controller.clubCategories.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.3,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) {
                          final category = controller.clubCategories[index];
                          return InkWell(
                            onTap: () => Get.to(() => ClubDetailsView(
                                  categoriesId: category['id'],
                                )),
                            child: Container(
                              height: 115,
                              width: 135,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff8983B2FF),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Centers the content vertically
                                children: [
                                  category['icon_img'] != null
                                      ? Image.network(
                                          category['icon_img'],
                                          height: 115,
                                          width: 135,
                                          fit: BoxFit.contain,
                                        )
                                      : SvgPicture.asset(
                                          AssetsPath.eduLogo,
                                          height:
                                              100, // Set height for the SVG if necessary
                                          width:
                                              100, // Set width for the SVG if necessary
                                        ),
                                ],
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
