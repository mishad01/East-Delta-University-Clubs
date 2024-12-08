import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/home/widget/highlight_slider.dart';
import 'package:edu_clubs_app/view/home/widget/home_banner_slider.dart';

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
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Clubs",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  child: GridView.builder(
                    itemCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Get.to(() => ClubDetailsView()),
                        child: Container(
                          height: 115,
                          width: 135,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff8983B2FF),
                          ),
                          child: SvgPicture.asset(AssetsPath.eduLogo),
                        ),
                      );
                    }, // Set an item count
                  ),
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    buildMembersOpinion(
                      "Asif Jofa",
                      "GM of commuter club",
                      "Being part of this club has been an incredible journey of growth, teamwork, and unforgettable experiences",
                      null,
                      Color(0xffFDEBB9),
                    ),
                    SizedBox(height: 15),
                    buildMembersOpinion(
                      "Asif Jofa",
                      "GM of commuter club",
                      "Being part of this club has been an incredible journey of growth, teamwork, and unforgettable experiences",
                      Spacer(),
                      Color(0xffD0D9FC),
                    ),
                    SizedBox(height: 15),
                    buildMembersOpinion(
                      "Asif Jofa",
                      "GM of commuter club",
                      "Being part of this club has been an incredible journey of growth, teamwork, and unforgettable experiences",
                      null,
                      Color(0xffD5D0FB),
                    ),
                  ],
                ),
              )
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
          ],
        ),
      ),
    );
  }
}
