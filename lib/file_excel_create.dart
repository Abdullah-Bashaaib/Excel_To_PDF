import 'package:exceltest/excel_testing.dart';
import 'package:exceltest/sqldb.dart';
import 'package:flutter/material.dart';

class FileExcelCreate extends StatefulWidget {
  const FileExcelCreate({super.key});

  @override
  State<FileExcelCreate> createState() => _FileExcelCreateState();
}

class _FileExcelCreateState extends State<FileExcelCreate> {
  SqlDb _sqldb = SqlDb();

  @override
  void initState() {
    // TODO: implement initState
    _sqldb.initalDb();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _nameStu = TextEditingController();
    final _ageStu = TextEditingController();
    final _gradeStu = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Excel Testing'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _nameStu,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please, Enter Your Name...";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Name Student',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageStu,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Plase, Enter your Age...";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Age', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(

                    keyboardType: TextInputType.number,
                    controller: _gradeStu,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please, Enter Values!";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Grade', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          int _age = int.parse(_ageStu.text);
                          List dataStu = [_nameStu.text, _age, _gradeStu.text];
                          var respone = _sqldb.insertData('''
                        Insert into Students (name_student,age,grade) values 
                        ('${dataStu[0]}',${dataStu[1]},'${dataStu[2]}')
                        ''');
                          print(respone.toString());
                          excelTesting.createExcelFile(dataStu);
                        }
                        // Excel.createExcel();

                        _gradeStu.clear();
                        _ageStu.clear();
                        _nameStu.clear();
                      },
                      child: Text('Save'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

