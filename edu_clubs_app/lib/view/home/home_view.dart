import 'package:edu_clubs_app/resources/app_colors.dart';
import 'package:edu_clubs_app/utils/custom_scaffold.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/admin/admin_control.dart';
import 'package:edu_clubs_app/view/auth/sign_in/sign_In_view.dart';
import 'package:edu_clubs_app/view/drawer/front_page_for_assignment.dart';
import 'package:edu_clubs_app/view/home/widget/all_categories_grid.dart';
import 'package:edu_clubs_app/view/home/widget/highlight_slider.dart';
import 'package:edu_clubs_app/view/home/widget/home_banner_slider.dart';
import 'package:edu_clubs_app/view/home/widget/members_opinion_widget.dart';
import 'package:edu_clubs_app/view/web/web_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "EDUAssist",
      title2: "Your academic assistant at EDU.",
      endDrawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Column(
            children: [
              const HomeBannerSlider(),
              SizedBox(height: 1.h),
              const AllCategoriesGrid(),
              SizedBox(height: 2.h),
              Text(
                "RECENT HIGHLIGHT",
                style: TextStyle(fontSize: 5.w, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              const HighLightSlider(),
              SizedBox(height: 2.h),
              Text(
                "WHAT OUR MEMBERS SAY",
                style: TextStyle(fontSize: 4.5.w, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              const MembersOpinionsWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with User Info
            UserAccountsDrawerHeader(
              accountName: Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              accountEmail: Text("",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 30.sp, color: Colors.blue),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetsPath.pdfEduLogo,
                  ),
                  opacity: 0.1,
                  scale: 5,
                ),
                color: AppColors.themeColor1,
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    icon: Icons.assignment,
                    text: 'Front Page for Assignment',
                    onTap: () => Get.to(() => FrontPageForAssignment()),
                  ),

                  _buildDrawerItem(
                    icon: Icons.update,
                    text: 'Student Forms & Updates',
                    onTap: () => Get.to(() => WebView(
                        link: "https://www.eastdelta.edu.bd/current-students")),
                  ),
                  _buildDrawerItem(
                    icon: Icons.group,
                    text: 'Faculty Members Info',
                    onTap: () => Get.to(
                      () => WebView(
                          link: "https://www.eastdelta.edu.bd/faculty-members"),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.group,
                    text: 'Admin Control',
                    onTap: () => Get.to(() => AdminControl()),
                  ),
                  const Divider(), // A separator for better UI
                  _buildDrawerItem(
                    icon: Icons.logout,
                    text: 'Sign Out',
                    onTap: () async {
                      await Supabase.instance.client.auth.signOut();
                      print('User signed out successfully');
                      Get.offAll(() => SignInView());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function for ListTile
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 6.w, color: Colors.blueAccent),
      title: Text(
        text,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
