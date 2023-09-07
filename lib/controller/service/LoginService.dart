import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unimatchteste/controller/UserController.dart';
import 'package:unimatchteste/controller/security/UserAuth.dart';

import '../../model/UserModel.dart';

class LoginService {
  Future<String> signIn(String email, String senha) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      print('Usuário autenticado com sucesso!');
      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .get();
      
      bool? primeiroLogin;
     

      if (primeiroLogin == true) {
        UserController userController = UserController(UserModel(
          uid: uid,
          nome: userDoc['nome'],
          email: userDoc['email'],
          telefone: userDoc['telefone'],
          datNasc: userDoc['data_nascimento'].toDate(),
          uni: userDoc['universidade'],
          uniPref: userDoc['universidade_preferida'],
          primeiroLogin: userDoc['primeiroLogin'],
          senha: userDoc['senha'],
        ));
        await userController.updatePrimeiroLogin(false);
        return 'first_login';
      } else {
        return 'success';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
