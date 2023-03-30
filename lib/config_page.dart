import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email = '',
      _dob = '',
      _university = '',
      _name = '',
      _phone = '',
      _password = '',
      _confirmPassword = '',
      _cpf = '',
      _preferredUniversity = '',
      _nu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Informações Pessoais'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (text) {
                      print(text);
                      _name = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nome é obrigatório.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      print(text);
                      _email = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email é obrigatório.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      print(text);
                      _phone = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Telefone é obrigatório.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      print(text);
                      _dob = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Data de nascimento é obrigatória.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Data de Nascimento',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      print(text);
                      _university = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Universidade é obrigatória.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Universidade',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      print(text);
                      _preferredUniversity = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Universidade preferida é obrigatória.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Universidade que mais lhe agrada',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      print(text);
                      _password = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Senha é obrigatória.';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      print(text);
                      _confirmPassword = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirme sua senha.';
                      }
                      if (value != _password) {
                        return 'As senhas não coincidem.';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            String uid = user.uid;
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .update({
                              'name': _name,
                              'email': _email,
                              'phone': _phone,
                              'dob': _dob,
                              'university': _university,
                              'preferredUniversity': _preferredUniversity,
                              'password': _password,
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          }
                        } catch (e) {
                          print('Erro: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao atualizar informações.'),
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Confirmar Alterações!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
