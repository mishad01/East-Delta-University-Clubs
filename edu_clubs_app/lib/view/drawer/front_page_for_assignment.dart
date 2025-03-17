import 'package:edu_clubs_app/resources/assets_path.dart';
import 'package:edu_clubs_app/utils/custom_text.dart';
import 'package:edu_clubs_app/utils/custom_text_field.dart';
import 'package:edu_clubs_app/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data' as typed_data;
import 'package:flutter/services.dart' show rootBundle;

class FrontPageForAssignment extends StatefulWidget {
  @override
  _FrontPageForAssignmentState createState() => _FrontPageForAssignmentState();
}

class _FrontPageForAssignmentState extends State<FrontPageForAssignment> {
  final TextEditingController _reportNameController = TextEditingController();
  final TextEditingController _submittedByController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _instructorNameController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text to PDF")),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AssetsPath.pdfEduLogo, height: 100),
              SizedBox(height: 20),
              buildCustomTextForPdf("Report:"),
              CustomTextFormField(
                  controller: _reportNameController,
                  labelText: "Enter Report Name"),
              SizedBox(height: 10),
              buildCustomTextForPdf("Submitted by:"),
              CustomTextFormField(
                  controller: _submittedByController,
                  labelText: "Enter Your Name"),
              SizedBox(height: 10),
              buildCustomTextForPdf("Student Id:"),
              CustomTextFormField(
                  controller: _studentIdController,
                  labelText: "Enter Student ID"),
              SizedBox(height: 10),
              buildCustomTextForPdf("Course Name:"),
              CustomTextFormField(
                  controller: _courseNameController,
                  labelText: "Enter Course Name"),
              SizedBox(height: 10),
              buildCustomTextForPdf("Course Instructor Name:"),
              CustomTextFormField(
                  controller: _instructorNameController,
                  labelText: "Enter Instructor Name"),
              SizedBox(height: 10),
              buildCustomTextForPdf("Date:"),
              CustomTextFormField(
                  controller: _dateController, labelText: "Enter Date"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generatePdf,
                child: Text("Download as PDF"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomTextForPdf(String text, {Color color = Colors.black}) {
    return CustomTextForPdf(
      text: text,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    final typed_data.ByteData bytes =
        await rootBundle.load(AssetsPath.pdfEduLogo);
    final typed_data.Uint8List byteList = bytes.buffer.asUint8List();
    final pw.MemoryImage image = pw.MemoryImage(byteList);
    final ttf = await PdfGoogleFonts.tinosRegular();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Image(image, height: 100),
              pw.SizedBox(height: 20),
              pw.Text(
                'Report\n${_reportNameController.text}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16,
                  font: ttf,
                  color: PdfColors.green,
                ), // Use predefined font weights
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Submitted by:',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  color: PdfColors.green,
                ),
              ),
              pw.SizedBox(
                width: 100,
                child: pw.Divider(thickness: 1),
              ),
              pw.Text(
                'NAME: ${_submittedByController.text}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                'STUDENT ID: ${_studentIdController.text}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                'COURSE NAME: ${_courseNameController.text}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                'INSTRUCTOR NAME: ${_instructorNameController.text}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  color: PdfColors.green,
                ),
              ),
              pw.Text(
                'DATE: ${_dateController.text}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  color: PdfColors.green,
                ),
              ),
            ],
          );
        },
      ),
    );

    // Show the PDF preview
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
