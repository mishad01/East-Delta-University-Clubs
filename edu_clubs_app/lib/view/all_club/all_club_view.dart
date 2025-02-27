import 'package:edu_clubs_app/resources/assets_path.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/club_details/club_details_view.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllClubView extends StatefulWidget {
  const AllClubView({super.key});

  @override
  State<AllClubView> createState() => _AllClubViewState();
}

class _AllClubViewState extends State<AllClubView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.2.w),
            child: GetBuilder<ClubCategoriesController>(
                builder: (clubCategoriesController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(3.2.w),
                    child: Text(
                      "All Clubs",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                  ),
                  Container(
                    // Set a fixed height for the grid view
                    child: Visibility(
                      visible: !clubCategoriesController.inProgress,
                      replacement: CircularProgressIndicator(),
                      child: GridView.builder(
                          itemCount:
                              clubCategoriesController.clubCategories.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 5.w,
                            mainAxisSpacing: 5.w,
                          ),
                          itemBuilder: (context, index) {
                            final category =
                                clubCategoriesController.clubCategories[index];
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
                                child: category['icon_img'] != null
                                    ? Image.network(
                                        category['icon_img'],
                                        height: 15.5.h,
                                        width: 30.5.w,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          // You can use a default image if the network image fails
                                          return SvgPicture.asset(
                                            AssetsPath.eduLogo,
                                            height: 10.h,
                                            width: 10.w,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          );
                                        },
                                      )
                                    : SvgPicture.asset(
                                        AssetsPath.eduLogo,
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                              ),
                            );
                          }
// Set an item count
                          ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
