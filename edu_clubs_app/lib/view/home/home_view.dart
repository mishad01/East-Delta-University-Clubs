import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/admin/admin_home_view_content_add/widget/members_opinion_widget.dart';
import 'package:edu_clubs_app/view/auth/sign_in/sign_In_view.dart';
import 'package:edu_clubs_app/view/home/widget/all_categories_grid.dart';
import 'package:edu_clubs_app/view/home/widget/highlight_slider.dart';
import 'package:edu_clubs_app/view/home/widget/home_banner_slider.dart';
import 'package:edu_clubs_app/view/home/widget/members_opinion_widget.dart';
import 'package:edu_clubs_app/view_model/user/sign_in_controller.dart';
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
          padding: const EdgeInsets.only(left: 40),
          child: Transform.scale(
            scale: 5,
            child: SvgPicture.asset(AssetsPath.eduLogo),
          ),
        ),
      ),
      endDrawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              HomeBannerSlider(),
              SizedBox(height: 5),
              AllCategoriesGrid(),
              Text("RECENT HIGHLIGHT",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 2.h),
              HighLightSlider(),
              SizedBox(height: 2.h),
              Text(
                "WHAT OUT MEMBER SAYS",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              MembersOpinionsWidgets()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMembersOpinion(
      String name, String club, String opinion, Widget? spacer, Color color) {
    return Row(
      children: [
        if (spacer != null) spacer,
        Container(
          height: 110,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(club,
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                Text(opinion, style: TextStyle(fontSize: 12))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Closes the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Closes the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context); // Closes the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
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
