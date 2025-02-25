import 'package:device_preview/device_preview.dart';
import 'package:edu_clubs_app/controller_binder.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:edu_clubs_app/view/admin/admin_club_categories_view.dart';
import 'package:edu_clubs_app/view/admin/all_club_details/admin_club_details_view.dart';
import 'package:edu_clubs_app/view/admin/admin_club_event/admin_club_event_view.dart';
import 'package:edu_clubs_app/view/admin/admin_club_faq/admin_club_faq_view.dart';
import 'package:edu_clubs_app/view/admin/admin_control.dart';
import 'package:edu_clubs_app/view/admin/admin_home_view_content_add/admin_home_view_content_add.dart';
import 'package:edu_clubs_app/view/admin/test.dart';
import 'package:edu_clubs_app/view/admin/test2.dart';

class EduClubsUser extends StatelessWidget {
  const EduClubsUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) {
        return GetMaterialApp(
          useInheritedMediaQuery: true,
          initialBinding: ControllerBinder(),
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: _themeData(),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => SplashView()),
          ],
        );
      },
    );
  }

  ThemeData _themeData() {
    return ThemeData(
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        bodySmall: GoogleFonts.roboto(color: Colors.black),
        bodyLarge: GoogleFonts.roboto(color: Colors.black),
        titleSmall: GoogleFonts.roboto(color: Colors.black),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.roboto(color: Colors.grey, fontSize: 15),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 1),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
