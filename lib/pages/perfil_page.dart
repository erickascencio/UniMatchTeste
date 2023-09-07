import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controller/service/PerfilService.dart';
// Substitua pelo caminho real do arquivo

final PerfilService perfilService = PerfilService();

class PerfilPage extends StatefulWidget {
  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<PerfilPage> {
  String genero = '';
  String bio = '';
  late File _image;
  String? email, uni, nome, telefone, senha, confSenha, cpf, uniPref, nu;
  String? imageUrl;
  String dropdownValue = 'Masculino';
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
      setState(() {
        email = user.email;
        nome = userData['nome'];
        uni = userData['universidade'];
        uniPref = userData['universidade_preferida'];
        imageUrl = userData['imagem_url'];
        bio = userData['bio'] ?? '';
        genero = userData['genero'] ?? 'Masculino';
        dropdownValue = genero;
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
                    await perfilService.uploadImageAndUpdateUrl(
                      user!,
                      (url) => setState(() {
                        imageUrl = url;
                      })
                    );
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
                // ... (parte restante do método build, como dropdown e campos de texto)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
