import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/admin/admin_home_view_content_add/widget/banner_widget.dart';
import 'package:edu_clubs_app/view/admin/admin_home_view_content_add/widget/prize_giving_card_widget.dart';
import 'package:edu_clubs_app/view/admin/admin_home_view_content_add/widget/members_opinion_widget.dart';
import 'package:edu_clubs_app/view/admin/admin_home_view_content_add/widget/section_title_widget.dart';
import 'package:edu_clubs_app/view/home/widget/highlight_slider.dart';

class AdminHomeViewContentAdd extends StatefulWidget {
  const AdminHomeViewContentAdd({super.key});

  @override
  State<AdminHomeViewContentAdd> createState() =>
      _AdminHomeViewContentAddState();
}

class _AdminHomeViewContentAddState extends State<AdminHomeViewContentAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      endDrawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BannerWidget(),
              SizedBox(height: 5),
              SectionTitleWidget(title: "RECENT HIGHLIGHT"),
              HighlightCardWidget(),
              SizedBox(height: 2.h),
              SectionTitleWidget(title: "WHAT OUR MEMBER SAYS"),
              MemberOpinionsWidget()
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Transform.scale(
          scale: 5,
          child: SvgPicture.asset(AssetsPath.eduLogo),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerItem(Icons.home, 'Home', context),
            _buildDrawerItem(Icons.settings, 'Settings', context),
            _buildDrawerItem(Icons.contact_page, 'Contact Us', context),
          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Closes the drawer
      },
    );
  }
}
