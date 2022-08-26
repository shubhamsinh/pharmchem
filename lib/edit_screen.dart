import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pharmchem/constants.dart';
import 'package:pharmchem/home_screen.dart';
import 'package:pharmchem/scanResult_screen.dart';

class editScreen extends StatefulWidget {
  const editScreen({super.key});

  @override
  State<editScreen> createState() => _editScreenState();
}

TextEditingController newData = TextEditingController();

class _editScreenState extends State<editScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Text',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          TextField(
            controller: newData..text = EditClass.editData,
            // initialValue: EditClass.editData,
            decoration: InputDecoration(
              hintText: EditClass.editData,
              border: textFieldBorder,
              enabledBorder: textFieldBorder,
              focusedBorder: textFieldBorder,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                EditClass.editData = newData.text;
                PrepopulatedData.resSym[EditClass.index] = newData.text;
                Navigator.pop(context);
              },
              child: Text("Save"))
        ],
      ),
    );
  }
}
