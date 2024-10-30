import 'package:device_preview/device_preview.dart';
import 'package:edu_clubs_app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => EduClubs(), // Wrap your app
    ),
  );
}
