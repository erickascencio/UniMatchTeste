import 'dart:io';

import '../UserController.dart';

class PerfilService {
  final UserController userController;

  PerfilService(this.userController);

  Future<void> updateUserData(Map<String, dynamic> data) async {
    return await userController.updateUserData(data);
  }

  Future<String> uploadImage(File image) async {
    return await userController.uploadImage(image);
  }
}
