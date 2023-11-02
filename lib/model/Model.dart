class UserModel {
  int? id;
  String? title;
  String? note;

  UserModel({this.id, this.title, this.note});

  userType() {
    Map<String, Object?> userMap = {};
    userMap['id'] = this.id;
    userMap['title'] = this.title;
    userMap['note'] = this.note;

    return userMap;
  }
}
