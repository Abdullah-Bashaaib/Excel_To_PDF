import 'package:exceltest/edit_data.dart';
import 'package:exceltest/export_pdf.dart';
import 'package:exceltest/sqldb.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'excel_testing.dart';

class Editpage extends StatefulWidget {
  const Editpage({super.key});

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      excelTesting.dataList;
    });
  }

  void exportToPdf() async {
    await PdfExport.generatePdf();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم التحويل إلى PDF بنجاح! \nالمسار: "),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
      ),
    );
  }

  // List<Map> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edting Data"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.deepPurple.shade200,
                ),
                height: 400,
                width: 1000,
                child: excelTesting.dataList
                        .isEmpty // التحقق من أن قاعدة البيانات تحتوي بيانات
                    ? const Center(
                        child: Text("No Data"),
                      )
                    : ListView.builder(
                        itemCount: excelTesting.dataList
                            .length, // طول القائمة التي تحتوي البيانات أو عدد البيانات الموجودة في قاعدة البيانات
                        itemBuilder: (BuildContext, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  "${excelTesting.dataList[index]['Name Student']}"),
                              subtitle: Text(
                                  "Age : ${excelTesting.dataList[index]['Age']} year , Grade : ${excelTesting.dataList[index]['grade']}"),
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              trailing: SizedBox(
                                width: 96,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        print("===============");
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditData(
                                              data: index,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        String? studentId =
                                            excelTesting.dataList[index]['Name Student'];

                                        // var check = await sqlDb.readData(
                                        //     'SELECT id FROM STUDENTS ');
                                        // if (check.isEmpty) {
                                        //   print("⚠️ لا يوجد سجل بهذا ID!");
                                        // }else{
                                        //   print('id = $studentId ============');
                                        // }

                                        if (studentId == null) {
                                          print(
                                              "⚠️ خطأ: الحقل ID غير موجود أو قيمته null للعنصر رقم $index");
                                          return;
                                        }

                                        var response = await sqlDb.deleteData(
                                            '''DELETE FROM STUDENTS WHERE name_student = "$studentId"''');
                                        excelTesting.dataList.removeAt(
                                            index); // إزالة العنصر من القائمة
                                        print('$response');
                                        setState(() {});
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text("Deleted Done"),
                                            duration: Duration(seconds: 3),
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(16),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  excelTesting.dataList.clear();
                  await excelTesting.readExcelFile();
                  setState(() {}); // إعادة بناء الواجهة بعد جلب البيانات
                },
                child: Text("Read Excel File ${excelTesting.dataList.length}"),
              ),
              ElevatedButton(
                onPressed: () async {
                  var per = await Permission.storage.request();
                  if (per.isGranted) {
                    PdfExport.generatePdf();
                    print("================================ Here");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تم التحويل إلى PDF بنجاح!"),
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(16),
                      ),
                    );
                  }
                },
                child: const Text("To PDF"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
