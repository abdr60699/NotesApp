import 'package:flutter/material.dart';
import 'package:grid_notes/control/DB_Connetion.dart';
import 'package:grid_notes/model/Model.dart';
import 'package:grid_notes/control/UserService.dart';
import 'package:grid_notes/control/repository.dart';
import 'reusableButtonWid.dart';
import 'reuseInputField.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen({this.userModel});

  UserModel? userModel;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();

  void initState() {
    _title.text = widget.userModel!.title.toString();
    _note.text = widget.userModel!.note.toString();
  }

  bool errorValidateTitle = false;
  bool errorValidateNote = false;

  DatabaseConnection justget = DatabaseConnection();
  Repository _repo = Repository();
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffff2147),
          centerTitle: true,
          title: Text('Update Notes'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ReusableInput(
                    isValid:
                        errorValidateTitle ? 'Title Can\'t be empty' : null,
                    hintText: 'Name',
                    userInput: _title,
                  ),
                  ReusableInput(
                    isValid: errorValidateNote ? 'Notes Can\'t be empty' : null,
                    hintText: 'Contact Number',
                    userInput: _note,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Reusable_Button(
                        buttText: 'update',
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
                            widget.userModel!.note = _note.text;
                            widget.userModel!.title = _title.text;
                            var results = await _userService
                                .updateData(widget.userModel!);
                            print('update $results');
                            Navigator.pop(context, results);
                          }
                        },
                      ),
                      const SizedBox(
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
