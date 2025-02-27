import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/auth/sign_in/sign_In_view.dart';
import 'package:edu_clubs_app/view/home/widget/all_categories_grid.dart';
import 'package:edu_clubs_app/view/home/widget/highlight_slider.dart';
import 'package:edu_clubs_app/view/home/widget/home_banner_slider.dart';
import 'package:edu_clubs_app/view/home/widget/members_opinion_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Transform.scale(
            scale: 2.5,
            child: SvgPicture.asset(AssetsPath.eduLogo),
          ),
        ),
      ),
      endDrawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Column(
            children: [
              HomeBannerSlider(),
              SizedBox(height: 1.h),
              AllCategoriesGrid(),
              Text(
                "RECENT HIGHLIGHT",
                style: TextStyle(fontSize: 5.w, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              HighLightSlider(),
              SizedBox(height: 2.h),
              Text(
                "WHAT OUR MEMBERS SAY",
                style: TextStyle(fontSize: 4.5.w, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              MembersOpinionsWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: Icon(Icons.home, size: 6.w),
              title: Text('Home', style: TextStyle(fontSize: 4.w)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 6.w),
              title: Text('Settings', style: TextStyle(fontSize: 4.w)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page, size: 6.w),
              title: Text('Contact Us', style: TextStyle(fontSize: 4.w)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, size: 6.w),
              title: Text('Sign Out', style: TextStyle(fontSize: 4.w)),
              onTap: () async {
                await Supabase.instance.client.auth.signOut();
                print('User signed out successfully');
                Get.offAll(() => SignInView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
