import 'package:flutter/material.dart';
import 'package:grid_notes/screens/AddScreen.dart';
import 'package:grid_notes/model/Model.dart';
import 'package:grid_notes/control/UserService.dart';
import 'package:grid_notes/control/repository.dart';
import 'package:grid_notes/screens/DetailedView.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';
import 'package:grid_notes/kConstants.dart';

class NotestScreen extends StatefulWidget {
  const NotestScreen({super.key});

  @override
  State<NotestScreen> createState() => _NotestScreenState();
}

class _NotestScreenState extends State<NotestScreen> {
  @override
  void initState() {
    getAllDataDB();
  }

  List<UserModel> userListAdd = [];

  Repository _repository = Repository();

  UserService _userService = UserService();

  getAllDataDB() async {
    var incomeDBData = await _userService.readAllData();
    userListAdd = <UserModel>[];
    incomeDBData.forEach((incomeDBData) {
      UserModel userModel = UserModel();

      userModel.id = incomeDBData['id'];
      userModel.title = incomeDBData['title'];
      userModel.note = incomeDBData['note'];
      setState(() {
        userListAdd.add(userModel);
      });

      return userModel;
    });
  }

  final List<Color> selectedColors = [
    Color.fromARGB(255, 222, 204, 204), // Light Grey
    Color(0xFFF5F5DC), // Beige
    Color(0xFFFFFACD), // Lemon Chiffon
    Color(0xFFF0FFF0), // Honeydew
    Color(0xFFFFE4C4), // Bisque
    Color(0xFFB0E57C), // Pale Green
    Color.fromARGB(255, 91, 199, 236), // Pink
    Color(0xFFAFEEEE), // Pale Turquoise
    Color(0xFFFFDAB9), // Peach Puff
    Color(0xFFD3D3D3), // Light Gray
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackGroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xffff2147),
        centerTitle: true,
        title: Text('Notes'),
      ),
      body: MasonryGridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        mainAxisSpacing: 4.0, // Vertical space between grid items
        crossAxisSpacing: 4.0,
        itemCount: userListAdd.length,
        itemBuilder: (context, index) {
          final randomColor =
              selectedColors[Random().nextInt(selectedColors.length)];

          return TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero),
            ),
            onPressed: () async {
              final updateScreen = Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailedView(
                    userSingleView: userListAdd[index],
                  ),
                ),
              );
              if (updateScreen != null) {
                getAllDataDB();
              }
            },
            child: Card(
                color: randomColor,
                child: ListTile(
                  title: Text(
                    ' ${userListAdd[index].title.toString()}',
                  ),

                  // subtitle: Text(
                  //   userListAdd[index].note.toString(),
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // leading: Icon(Icons.notes),
                  // leading: Column(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () async {
                  //         var _trigggerScreen = await Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => UpdateScreen(
                  //               userModel: userListAdd[index],
                  //             ),
                  //           ),
                  //         );
                  //         if (_trigggerScreen != null) {
                  //           getAllDataDB();
                  //         }
                  //       },
                  //       icon: Icon(
                  //         Icons.edit_document,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  trailing: IconButton(
                      onPressed: () async {
                        print(' before   ${userListAdd.length}');
                        if (userListAdd.length == 1) {
                          await _userService.deleteUser(userListAdd[index].id);
                          setState(() {
                            userListAdd = [];
                          });
                        } else {
                          await _userService.deleteUser(userListAdd[index].id);
                          getAllDataDB();
                        }
                      },
                      icon: Icon(Icons.delete_forever)),
                )),
          );
        },
        // itemCount: userListAdd.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff2147),
        child: Icon(Icons.add),
        onPressed: () async {
          var _trigggerScreen = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
          if (_trigggerScreen != null) {
            getAllDataDB();
          }
        },
      ),
    );
  }
}
