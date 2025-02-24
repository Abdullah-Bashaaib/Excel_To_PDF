import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'sqldb.dart';

class PdfExport {
  static Future<void> generatePdf() async {
    final pdf = pw.Document();
    var data = await sqlDb.readData("SELECT * FROM Students");

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: data
                .map((e) => pw.Text(
                    "${e['name_student']} - Age: ${e['age']} - Grade: ${e['grade']}"))
                .toList(),
          );
        },
      ),
    );



    final file = File("/storage/emulated/0/Download/students_data1-1.pdf");
    await file.writeAsBytes(await pdf.save());

  }
}

PdfExport pdfExport = PdfExport();
