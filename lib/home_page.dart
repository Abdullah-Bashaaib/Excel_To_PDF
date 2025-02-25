import 'package:exceltest/editPage.dart';
import 'package:exceltest/edit_data.dart';
import 'package:exceltest/excel_testing.dart';
import 'package:exceltest/sqldb.dart';
import 'package:flutter/material.dart';

import 'file_excel_create.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // readFile() async {
  //   List<Map> data = await sqlDb.readData('''
  //     SELECT * FROM Students;
  //                                   ''');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Excel Testing"),
        ),
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Editpage()));
                    },
                    child: Text("Edit Page")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FileExcelCreate()));
                    },
                    child: Text("Create File")),
              ],
            ),
          ),
        ));
  }
}
