import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/club_details/club_details_view.dart';
import 'package:edu_clubs_app/view_model/categories/club_category_controller.dart';

class AllCategoriesGrid extends StatelessWidget {
  const AllCategoriesGrid({super.key});

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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => AllClubView());
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
            // Wrap GridView.builder in a Container or Expanded widget
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 35.0.h, // Set a fixed height for the grid view

                child: controller.inProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      ) // Loading indicator while fetching
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
                          return InkWell(
                            onTap: () => Get.to(() => ClubDetailsView(
                                  categoriesId: category['id'],
                                )),
                            child: Container(
                              height: 12.5.h,
                              width: 13.5.w,
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
                                          height: 15.5.h,
                                          width: 30.5.w,
                                          fit: BoxFit.contain,
                                        )
                                      : SvgPicture.asset(
                                          AssetsPath.eduLogo,
                                          height: 10.h,
                                          width: 10.w,
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
