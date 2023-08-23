import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {

  String nome;
  String email;
  String telefone;
  DateTime datNasc;
  String uni;
  String uniPref;
  String senha;
  String confSenha;

  UserModel({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.datNasc,
    required this.uni,
    required this.uniPref,
    required this.senha,
    required this.confSenha,
  });

 Future<void> registerUser() async {
  try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: senha);
          print('Usuário criado com sucesso!');
          String uid = userCredential.user!.uid;
          await FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
            'nome': nome,
            'email': email,
            'telefone': telefone,
            'data_nascimento': Timestamp.fromDate(datNasc),
            'universidade': uni,
            'universidade_preferida': uniPref,
            'senha': senha,
            'uid': uid,
          });
        } catch (e) {
          print(e);
        }
      }
}