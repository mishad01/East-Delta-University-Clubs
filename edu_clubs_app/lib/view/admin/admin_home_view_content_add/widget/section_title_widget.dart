import 'package:edu_clubs_app/utils/export.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;

  SectionTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
