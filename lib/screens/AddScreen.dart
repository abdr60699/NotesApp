import 'package:flutter/material.dart';
import 'package:grid_notes/control/DB_Connetion.dart';
import 'package:grid_notes/model/Model.dart';
import 'package:grid_notes/control/UserService.dart';
import 'package:grid_notes/control/repository.dart';
import 'reusableButtonWid.dart';
import 'reuseInputField.dart';
import 'package:grid_notes/kConstants.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();

  bool errorValidateTitle = false;
  bool errorValidateNote = false;

  DatabaseConnection justget = DatabaseConnection();
  Repository _repo = Repository();
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kAppBackGroundColor,
        appBar: AppBar(
          backgroundColor: Color(0xffff2147),
          centerTitle: true,
          title: Text('Add Notes'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ReusableInput(
                    labelText: 'Title',
                    isValid:
                        errorValidateTitle ? 'Title Can\'t be empty' : null,
                    userInput: _title,
                  ),
                  ReusableInput(
                    labelText: 'Notes',
                    isValid: errorValidateNote ? 'Notes Can\'t be empty' : null,
                    userInput: _note,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Reusable_Button(
                        buttText: 'Save',
                        onPress: () async {
                          setState(() {
                            _note.text == ''
                                ? errorValidateNote = true
                                : errorValidateNote = false;
                            _title.text == ''
                                ? errorValidateTitle = true
                                : errorValidateTitle = false;
                          });

                          if (errorValidateNote == false &&
                              errorValidateTitle == false) {
                            UserModel _userModel = UserModel();
                            _userModel.note = _note.text;
                            _userModel.title = _title.text;
                            var results =
                                await _userService.inserAllData(_userModel);
                            print(results);
                            Navigator.pop(context, results);
                          }
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Reusable_Button(
                        buttText: 'Clear',
                        onPress: () {
                          setState(() {
                            _title.text = '';
                            _note.text = '';
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
