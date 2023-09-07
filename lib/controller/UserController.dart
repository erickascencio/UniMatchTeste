import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unimatchteste/model/UserModel.dart';

class UserController {
UserModel user;

  UserController(this.user);

  void updateNome(String nome) {
    user.nome = nome;
  }

  void updateEmail(String email) {
    user.email = email;
  }

  void updateTelefone(String telefone) {
    user.telefone = telefone;
  }

  void updateDatNasc(DateTime datNasc) {
    user.datNasc = datNasc;
  }

  void updateUni(String uni) {
    user.uni = uni;
  }

  void updateUniPref(String uniPref) {
    user.uniPref = uniPref;
  }

  void updateSenha(String senha) {
    user.senha = senha;
  }



  void updateConfSenha(String confSenha) {
   user.confSenha = confSenha;
  }

   Future<void> updateUserData(Map<String, dynamic> data) async {
    return await user.updateUserData(data);
  }

  Future<String> uploadImage(File image) async {
    return await user.uploadImage(image);
  }

  Future<void> updatePrimeiroLogin(bool primeiroLogin) async {
    user.primeiroLogin = primeiroLogin;
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .update({'primeiroLogin': primeiroLogin});
  }

  Future<void> registerUser() async {
    return user.registerUser();
  }
}