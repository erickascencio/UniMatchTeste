import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UserModel {

  String uid;
  String nome;
  String email;
  String telefone;
  DateTime datNasc;
  String uni;
  String uniPref;
  String senha;
  String confSenha;
  bool primeiroLogin;

  UserModel({
     required this.uid,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.datNasc,
    required this.uni,
    required this.uniPref,
    required this.senha,
    this.confSenha = '',
    this.primeiroLogin = true,
  });

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> updateUserData(Map<String, dynamic> data) async {
    await _db.collection('usuarios').doc(uid).update(data);
  }

  Future<String> uploadImage(File image) async {
    final Reference storageRef = _storage.ref().child('perfil').child(uid).child(basename(image.path));
    final UploadTask uploadTask = storageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return await taskSnapshot.ref.getDownloadURL();
  }

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
            'uid': uid,
            'primeiroLogin': primeiroLogin,
          });
        } catch (e) {
          print(e);
        }
      }
}