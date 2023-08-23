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

  Future<void> registerUser() async {
    return user.registerUser();
  }
}