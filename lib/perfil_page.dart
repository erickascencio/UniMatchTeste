import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'config_page.dart';
import 'login_page.dart';

class PerfilPage extends StatefulWidget {
  // cria um estado HomePage
  @override // Da pra alterar enquanto roda o app
  State<PerfilPage> createState() {
    // Dinamico
    return PerfilPageState();
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class PerfilPageState extends State<PerfilPage> {
  String genero = '';
  String bio = '';
  late File _image;
  int counter = 0;
  String? email, uni, nome, telefone, senha, confSenha, cpf, uniPref, nu;
  String? imageUrl;
  String dropdownValue = 'Masculino';
  User? user = _auth.currentUser;

  @override
  void initState() {
    super.initState();
    getUserData();
    String dropdownValue = genero.isNotEmpty ? genero : 'Masculino';
  }

  Future<void> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _db.collection('usuarios').doc(user.uid).get();
      setState(() {
        email = user.email;
        nome = userData['nome']!;
        uni = userData['universidade'];
        uniPref = userData['universidade_preferida'];
        imageUrl = userData['imagem_url'];
        bio = userData['bio'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      if (imageUrl != null)
                        Container(
                          height: 220,
                          width: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(imageUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'Adicione suas fotos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        _image = File(pickedFile.path);
                      });
                      if (_image != null) {
                        final Reference storageRef = FirebaseStorage.instance
                            .ref()
                            .child('perfil')
                            .child(user!.uid)
                            .child(basename(_image.path));
                        final UploadTask uploadTask =
                            storageRef.putFile(_image);
                        final TaskSnapshot taskSnapshot = await uploadTask;
                        final String downloadUrl =
                            await taskSnapshot.ref.getDownloadURL();
                        await FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(user!.uid)
                            .update({'imagem_url': downloadUrl});
                        setState(() {
                          imageUrl = downloadUrl;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Upload de imagem realizado com sucesso'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Nenhuma imagem selecionada'),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Upload de Fotos'),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'Nome de Usuário: $nome',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Gênero',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                    genero = dropdownValue;
                                  });
                                },
                                items: <String>[
                                  'Masculino',
                                  'Feminino',
                                  'Outro'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  maxLines: 5,
                  maxLength: 500,
                  onChanged: (text) {
                    print(text);
                    bio = text;
                  },
                  decoration: InputDecoration(
                    labelText: 'Descrição (500 caracteres)',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: bio),
                ),
                Container(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('usuarios')
                        .doc(user!.uid)
                        .update({
                      'genero': genero,
                      'bio': bio,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dados atualizados com sucesso'),
                      ),
                    );
                  },
                  child: Text('Atualizar Dados'),
                ),
                Container(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
