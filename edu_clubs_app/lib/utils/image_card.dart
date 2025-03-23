import 'package:edu_clubs_app/utils/export.dart';

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
      width: 260,
      height: 280,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(26)),
        color: Colors.black,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Container(
                    //color: Colors.yellow,
                    width: 300,
                    child: Text(
                      eventTitle,
                      style: GoogleFonts.sourceSerif4(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 80,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      prizeGivingDate,
                      style: GoogleFonts.sourceSerif4(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              // color: Colors.yellow,
              height: 225,
              width: 245,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: Image.network(
                  prizeGivingImage,
                  height: 225,
                  width: 228,
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
                      ),
                    );
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
