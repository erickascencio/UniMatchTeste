import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'home_page.dart';
import 'login_page.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class _CadastroPageState extends State<CadastroPage> {
  bool _allFieldsFilled = false;
  late File _image;
  DateTime datNasc = DateTime.now();
  String email = '',
      Uni = '',
      nome = '',
      Telefone = '',
      senha = '',
      ConfSenha = '',
      UniPref = '',
      Nu = '';

  void _checkFields() {
    if (nome.isNotEmpty &&
        email.isNotEmpty &&
        Telefone.isNotEmpty &&
        datNasc != null &&
        Uni.isNotEmpty &&
        UniPref.isNotEmpty &&
        senha.isNotEmpty &&
        ConfSenha.isNotEmpty) {
      setState(() {
        _allFieldsFilled = true;
      });
    } else {
      setState(() {
        _allFieldsFilled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Molda a tela para se assemelhar a um App
        centerTitle: true,
        title: Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        //permite dar Scroll na tela enquanto digita
        child: SizedBox(
          //Box de Login
          width: MediaQuery.of(context).size.width, // delimita o tamanho (X,Y)
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0), //Distancia da borda do celular
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (text) {
                    print(text);
                    nome = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    // coloca borda no textfield
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    print(text);
                    email = text;
                    _checkFields();
                  },
                  decoration: InputDecoration(
                    // coloca borda no textfield
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    print(text);
                    Telefone = text;
                    _checkFields();
                  },
                  decoration: InputDecoration(
                    // coloca borda no textfield
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    print(text);
                    datNasc = DateTime.parse(text);
                    _checkFields();
                  },
                  decoration: InputDecoration(
                    // coloca borda no textfield
                    labelText: 'Data de Nascimento',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    print(text);
                    Uni = text;
                    _checkFields();
                  },
                  decoration: InputDecoration(
                    // coloca borda no textfield
                    labelText: 'Universidade',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    print(text);
                    UniPref = text;
                    _checkFields();
                  },
                  decoration: InputDecoration(
                    // coloca borda no textfield
                    labelText: 'Universidade que mais lhe agrada',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    print(text);
                    senha = text;
                    _checkFields();
                  },
                  obscureText: true, //deixa senha nao visivel
                  decoration: InputDecoration(
                    // coloca borda no textfield
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    print(text);
                    ConfSenha = text;
                    _checkFields();
                  },
                  obscureText: true, //deixa senha nao visivel
                  decoration: InputDecoration(
                    // coloca borda no textfield
                    labelText: 'Confirmar senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _allFieldsFilled
                      ? () async {
                          if (senha == ConfSenha) {
                            if (senha.length < 6) {
                              // Adicione este código para notificar o usuário quando a senha é fraca
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'A senha deve ter pelo menos 6 caracteres'),
                                ),
                              );
                            } else {
                              // Verifica se o usuário já está logado antes de criar uma nova conta
                              if (_auth.currentUser != null) {
                                await _auth.signOut();
                              }
                              try {
                                UserCredential userCredential =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: senha);
                                print('Usuário criado com sucesso!');
                                // Adicionar dados ao Firestore
                                String uid = userCredential.user!.uid;
                                await FirebaseFirestore.instance
                                    .collection('usuarios')
                                    .doc(uid)
                                    .set({
                                  'nome': nome,
                                  'email': email,
                                  'telefone': Telefone,
                                  'data_nascimento':
                                      Timestamp.fromDate(datNasc),
                                  'universidade': Uni,
                                  'universidade_preferida': UniPref,
                                  'senha': senha,
                                  'uid':
                                      uid // Adiciona o UID do usuário no Firestore
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('A senha é muito fraca'),
                                    ),
                                  );
                                } else if (e.code == 'email-already-in-use') {
                                  // Adicione este código para notificar o usuário quando o email já está em uso
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('O email já está em uso'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          } else {
                            // Adicione este código para notificar o usuário quando a confirmação de senha não for igual à senha
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('As senhas não conferem'),
                              ),
                            );
                          }
                        }
                      : null,
                  child: Icon(Icons.done),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
