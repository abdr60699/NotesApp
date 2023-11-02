import 'package:flutter/material.dart';
import 'package:grid_notes/control/DB_Connetion.dart';
import 'package:grid_notes/model/Model.dart';
import 'package:grid_notes/control/UserService.dart';
import 'package:grid_notes/control/repository.dart';
import 'reusableButtonWid.dart';
import 'reuseInputField.dart';
import 'package:grid_notes/kConstants.dart';

class DetailedView extends StatefulWidget {
  DetailedView({this.userSingleView});

  UserModel? userSingleView;

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _title.text = widget.userSingleView!.title.toString() ?? '';
    _note.text = widget.userSingleView!.note.toString();
  }

  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();

  bool errorValidateTitle = false;
  bool errorValidateNote = false;

  DatabaseConnection justget = DatabaseConnection();
  Repository _repo = Repository();
  UserService _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff2147),
        centerTitle: true,
        title: Text('Notes'),
      ),
      backgroundColor: kAppBackGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ReusableInput(
                  isValid: errorValidateTitle ? 'Title Can\'t be empty' : null,
                  hintText: 'Title',
                  labelText: 'Title',
                  userInput: _title,
                ),
                ReusableInput(
                  labelText: 'Notes',
                  isValid: errorValidateNote ? 'Notes Can\'t be empty' : null,
                  hintText: 'Notes',
                  userInput: _note,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Reusable_Button(
                      buttText: 'Update',
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
                          widget.userSingleView!.note = _note.text;
                          widget.userSingleView!.title = _title.text;
                          var results = await _userService
                              .updateData(widget.userSingleView!);
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
    );
  }
}
