import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unimatchteste/model/UserModel.dart';

class CadastroService {
  UserModel user;

  CadastroService(this.user);

  Future<void> registerUser() async {
    if (!checkFields()) {
      showToast("Todos os campos devem ser preenchidos");
      return;
    }

    if (!checkPassword()) {
      showToast("As senhas não coincidem");
      return;
    }

    if (!await checkEmail()) {
      showToast("O email já está sendo utilizado");
      return;
    }

    await user.registerUser();
    showToast("Usuário registrado com sucesso");
  }

  bool checkFields() {
    if (user.nome.isEmpty ||
        user.email.isEmpty ||
        user.telefone.isEmpty ||
        user.datNasc == null ||
        user.uni.isEmpty ||
        user.uniPref.isEmpty ||
        user.senha.isEmpty ||
        user.confSenha.isEmpty) {
      return false;
    }
    return true;
  }

  bool checkPassword() {
    return user.senha == user.confSenha;
  }

   Future<bool> checkEmail() async {
    try {
      List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(user.email);
      bool isEmailAvailable = signInMethods.isEmpty;
      
      if (!isEmailAvailable) {
        showToast("O email já está sendo utilizado");
      }
      
      return isEmailAvailable;
    } catch (e) {
      print("Erro ao verificar email: $e");
      return false;
    }
  }


  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}
