import 'package:device_preview/device_preview.dart';
import 'package:edu_clubs_app/app.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => EduClubs(),
  ));
}
