import 'package:edu_clubs_app/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EventImageCard extends StatelessWidget {
  final String prizeGivingDate;
  final String prizeGivingImage;
  final String eventTitle;

  const EventImageCard({
    super.key,
    required this.prizeGivingDate,
    required this.prizeGivingImage,
    required this.eventTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SvgPicture.asset(
            AssetsPath.card,
            width: 80.w,
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 7.w, top: .8.h),
            child: Text(
              eventTitle,
              style: GoogleFonts.sourceSerif4(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60.w, top: .5.h),
            child: Text(
              prizeGivingDate,
              style: GoogleFonts.sourceSerif4(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),
            ),
          ),
          Positioned(
            top: 7.h,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: Image.network(
                  prizeGivingImage,
                  height: 32.h,
                  width: 72.w,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
