import 'package:edu_clubs_app/utils/custom_scaffold.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/admin/admin_club_categories_view.dart';
import 'package:edu_clubs_app/view/admin/admin_club_details_view.dart';
import 'package:edu_clubs_app/view/admin/admin_club_event_view.dart';
import 'package:edu_clubs_app/view/admin/admin_club_faq_view.dart';
import 'package:edu_clubs_app/view/admin/admin_home_view_content_add/admin_home_view_content_add.dart';

class AdminControl extends StatefulWidget {
  const AdminControl({super.key});

  @override
  State<AdminControl> createState() => _AdminControlState();
}

class _AdminControlState extends State<AdminControl> {
  final List<Widget> adminView = [
    AdminHomeViewContentAdd(),
    AdminClubCategoryView(),
    AdminClubDetailsView(),
    AdminClubEventView(),
    AdminClubFAQView(),
  ];

  final List<String> text = [
    'Home Screen',
    'Add Category',
    'Add Club Details',
    'Add Club Event',
    'Add Club FAQ',
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.category,
    Icons.info,
    Icons.event,
    Icons.help,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Admin Control",
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: adminView.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => adminView[index]);
                    },
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [Colors.blueAccent, Colors.lightBlue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index],
                              size: 40,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              text[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
          ],
        ),
      ),
    );
  }
}
