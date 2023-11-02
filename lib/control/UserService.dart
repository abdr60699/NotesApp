import 'package:grid_notes/model/Model.dart';
import 'package:grid_notes/control/repository.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

//Read ALL Notes

  Future<dynamic> readAllData() async {
    return await _repository.reporeadAll('notes');
  }

  // insert notes

  Future<int> inserAllData(UserModel inputTable) async {
    return await _repository.repoinsertData('notes', inputTable);
  }

  //

  Future<int> deleteUser(id) async {
    return await _repository.repoDelete('notes', id);
  }

  Future<int> updateData(UserModel inputTable) async {
    return await _repository.repoUpdate('notes', inputTable.userType());
  }
}
