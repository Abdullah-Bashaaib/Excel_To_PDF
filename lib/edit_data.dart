import 'package:flutter/material.dart';
import 'package:exceltest/sqldb.dart';

class EditData extends StatefulWidget {
  EditData({super.key, required this.data});
  final data;
  late final controller;

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formState = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _gradeController = TextEditingController();

  @override
  void initState()  {
    // TODO: implement initState
    // List<Map> data = await sqlDb.readData('''
    // SELECT * FROM Students;
    // ''');
    // widget.controller = data;
    // _nameController.text = widget.controller[widget.data]['name_student'];
    // _ageController.text = widget.controller[widget.data]['age'];
    // _nameController.text = widget.controller[widget.data]['grade'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edting Data"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formState,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
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
                  controller: _ageController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Please, Enter your Age...";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Age', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _gradeController,
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
                      if (_formState.currentState!.validate()) {
                        int _age = int.parse(_ageController.text);
                        List dataStu = [
                          _nameController.text,
                          _age,
                          _gradeController.text
                        ];
                        var respone = sqlDb.updateData('''
                        UPDATE Students 
                        SET name_student = ${_nameController.text}
                        WHERE ID = ${widget.data}
                        ''');
                        print(respone.toString());
                        // excelTesting.createExcelFile(dataStu);
                      }
                      // Excel.createExcel();

                      // _gradeController.clear();
                      // _ageController.clear();
                      // _nameController.clear();
                    },
                    child: Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
