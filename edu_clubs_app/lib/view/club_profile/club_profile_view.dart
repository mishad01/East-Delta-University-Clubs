import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/club_profile/widget/club_details_slider.dart';

class ClubDetailsView extends StatefulWidget {
  const ClubDetailsView({super.key});

  @override
  State<ClubDetailsView> createState() => _ClubDetailsViewState();
}

class _ClubDetailsViewState extends State<ClubDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Photography Club",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 2.h),
              ClubDetailsSlider(),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What We Do",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "Being part of this club has been an incredible journey of growth,teamwork, and unforgettable experiencesBeing part of this club has been an incredible journey of growth,teamwork, and unforgettable experiences"),
                    SizedBox(height: 1.h),
                    Text(
                      "Why Join Us",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
}
