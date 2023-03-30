import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unimatchteste/login_page.dart';
import 'package:unimatchteste/perfil_page.dart';
import 'package:unimatchteste/cadastro_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late String _otherUserImageUrl = '';
  late String _otherUserName = '';
  late String _otherUserUniversity = '';
  late String _otherUserBio = '';
  late String _otherUserUid = '';
  List<String> _usedUserUids = []; // Lista de UIDs de usuários já exibidos

  Future<void> _checkMatch(String currentUserUid) async {
    final likesRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(_otherUserUid)
        .collection('likes');
    final likeDoc = await likesRef.doc(currentUserUid).get();
    if (likeDoc.exists) {
      // Verificar se houve match
      final otherUserLikesRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(currentUserUid)
          .collection('likes');
      final otherUserLikeDoc = await otherUserLikesRef.doc(_otherUserUid).get();
      if (otherUserLikeDoc.exists) {
        _showDialog('Você deu um Match!!');
        // Cria a coleção 'match' no banco de dados do Firebase
        final matchRef = FirebaseFirestore.instance
            .collection('usuarios')
            .doc(currentUserUid)
            .collection('matches')
            .doc(_otherUserUid);
        matchRef.set({});
      } else {
        await likesRef.doc(currentUserUid).set({});
        _showDialog('Você já deu like neste usuário.');
      }
    } else {
      await likesRef.doc(currentUserUid).set({});
    }
  }

  Future<void> _loadOtherUserData() async {
    final random = Random();
    final currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserUid == null) {
      return;
    }
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('usuarios').get();
    List<QueryDocumentSnapshot> documents = snapshot.docs
        .where((doc) =>
            doc.id != currentUserUid && !_usedUserUids.contains(doc.id))
        .toList();
    if (documents.isEmpty) {
// Resetar a lista de UIDs usados se todos já foram exibidos
      _usedUserUids.clear();
      documents = snapshot.docs
          .where((doc) =>
              doc.id != currentUserUid && !_usedUserUids.contains(doc.id))
          .toList();
      if (documents.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sem usuários novos no momento.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        return;
      }
    }
    QueryDocumentSnapshot document =
        documents[random.nextInt(documents.length)];
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    setState(() {
      _otherUserUid = document.id;
      _otherUserName = data?['nome'] ?? '';
      _otherUserUniversity = data?['universidade'] ?? '';
      _otherUserBio = data?['bio'] ?? '';
      _otherUserImageUrl = data?['imagem_url'] ?? '';
      _usedUserUids.add(
          _otherUserUid); // Adicionar o UID do usuário exibido à lista de UIDs usados
    });
  }

  Future<Map<String, dynamic>?> getOtherUserData(String uid) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    return snapshot.data() as Map<String, dynamic>?;
  }

  void _showUserInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildUserInfoDialogContent(),
        );
      },
    );
  }

  Widget _buildUserInfoDialogContent() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _otherUserName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            _otherUserUniversity,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Text(_otherUserBio),
            ),
          ),
        ],
      ),
    );
  }

  void _checkUsedUserUids() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('usuarios').get();
    final numUsers = snapshot.docs.length;
    if (_usedUserUids.length == numUsers - 1) {
      _showNoMoreUsersDialog();
    }
  }

  void _showNoMoreUsersDialog() {
    _showDialog('Sem usuários novos no momento.');
  }

  void _showDialog(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadOtherUserData();
    _checkUsedUserUids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('UniMatch'),
        actions: [
          FilledButton.icon(
            icon: Icon(Icons.chat_rounded),
            label: Container(
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/perfil');
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.pink[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              heightFactor: 1.1,
              child: SizedBox(
                child: Container(
                  height: 562,
                  width: 340,
                  color: Colors.white,
                  child: Image.network(
                    _otherUserImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/images/deslike.png'),
                  iconSize: 40,
                  onPressed: () async {
                    await _loadOtherUserData();
                    _checkUsedUserUids();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  iconSize: 40,
                  color: Colors.black,
                  onPressed: _showUserInfoDialog,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/like.png'),
                      iconSize: 40,
                      onPressed: () async {
                        final currentUserUid =
                            FirebaseAuth.instance.currentUser?.uid;
                        if (currentUserUid == null) {
                          return;
                        }
                        await _checkMatch(currentUserUid);
                        await _loadOtherUserData();
                        _checkUsedUserUids();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 27.0)),
            ),
            ListTile(
              title: Text(
                'Perfil',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/perfil');
              },
            ),
            ListTile(
              title: Text(
                'Configurações',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/config');
              },
            ),
            ListTile(
              title: Text(
                'Sair',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
