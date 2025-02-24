import 'dart:io';
import 'package:exceltest/sqldb.dart';
import 'package:flutter_excel/excel.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class ExcelTesting {
  var excel = Excel.createExcel();
  List<Map<String, dynamic>> dataList = []; // قائمة لتخزين البيانات


  void createExcelFile(List data) async {
    Sheet _sheet = excel['sheet2'];
    var _cell = _sheet.cell(CellIndex.indexByString('A1'));
    var _cell2 = _sheet.cell(CellIndex.indexByString('B1'));
    var _cell3 = _sheet.cell(CellIndex.indexByString('C1'));

    _cell.value = "Name Student";
    _cell2.value = 'Age';
    _cell3.value = 'grade';

    _sheet.appendRow(data);

    saveExcelFile();
  }

  saveExcelFile() async {
    var _per = await Permission.storage.request();
    var _fileByte = excel.save();
    if (_per.isGranted) {
      File(join('/storage/emulated/0/Download/billNo2-2.xlsx'))
        ..createSync(recursive: false)
        ..writeAsBytesSync(_fileByte!);
      print(
          "Doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee!!");
    } else {
      print('Permission Depined!');
    }
  }

  readExcelFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    var respone;

    if (result != null) {
      File file = File(result.files.single.path!);
      print("Selected Path $file");
      var byte = file!.readAsBytesSync();
      var excelRead = Excel.decodeBytes(byte);
      int j = 0;
      int i = 0;
      List<String> headers = []; // قائمة لحفظ أسماء الأعمدة

      for (var table in excelRead.tables.keys) {
        var sheet = excelRead.tables[table];
        if (sheet != null) {
          int rowIndex = 0;

          for (var row in sheet.rows) {
            if (rowIndex == 0) {
              // حفظ أسماء الأعمدة من أول صف
              headers =
                  row.map((cell) => cell?.value.toString() ?? "").toList();
            } else {
              // إنشاء ماب لكل صف بناءً على أسماء الأعمدة
              Map<String, dynamic> rowData = {};
              for (int colIndex = 0; colIndex < row.length; colIndex++) {
                rowData[headers[colIndex]] = row[colIndex]?.value;
              }
              dataList.add(rowData);
              respone = await sqlDb.insertData('''
                        Insert into Students (name_student,age,grade) values
                        ('${rowData['Name Student']}',${rowData['Age']},'${rowData['grade']}')
                        '''); // اضافة البيانات من ملف الاكسل الى قاعدة البيانات
            }

            rowIndex++;
          }
        }
      }

      // ✅ طباعة البيانات على شكل ماب
      for (var row in dataList) {
        print(row);
      }
    } else {
      print("❌ لم يتم اختيار أي ملف");
    }

    return respone;
  }

}

ExcelTesting excelTesting = ExcelTesting();
