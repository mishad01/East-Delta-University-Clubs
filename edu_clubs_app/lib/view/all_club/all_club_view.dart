import 'package:edu_clubs_app/resources/assets_path.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Clubs",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("See All"),
                    ),
                  ],
                ),
                Container(
                  // Set a fixed height for the grid view
                  child: GridView.builder(
                    itemCount: 15,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 115,
                        width: 135,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff8983B2FF),
                        ),
                        child: SvgPicture.asset(AssetsPath.eduLogo),
                      );
                    }, // Set an item count
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
