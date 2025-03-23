import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/export.dart';

class CustomScaffold extends StatelessWidget {
  final String? title;
  final String? title2;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions; // New actions parameter
  final Widget? endDrawer; // Added endDrawer parameter

  const CustomScaffold({
    super.key,
    this.title,
    this.title2,
    required this.body,
    this.floatingActionButton,
    this.actions,
    this.endDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "Default Title",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
                fontSize: 24,
              ),
            ),
            Text(
              title2 ?? "Default Subtitle",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Transform.scale(
            scale: 2.5,
            child: SvgPicture.asset(AssetsPath.eduLogo),
          ),
        ),
        actions: actions, // Added actions to AppBar
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      endDrawer: endDrawer, // Added endDrawer to Scaffold
    );
  }
}
