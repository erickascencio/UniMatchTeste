import 'package:flutter/material.dart';
import 'package:unimatchteste/pages/Chat/chatHomeScreen.dart';
import 'package:unimatchteste/pages/Chat/chat_page.dart';
import 'package:unimatchteste/pages/cadastro_page.dart';
import 'package:unimatchteste/pages/config_page.dart';
import 'package:unimatchteste/pages/loading_page.dart';
import 'package:unimatchteste/pages/perfil_page.dart';
import 'login_page.dart';

import 'home_page.dart';


class AppWidget extends StatelessWidget{ // cria uma build AppWidget
  // Nao da pra alterar enquanto roda o App
  // estatico
  @override
  Widget build(BuildContext context){
    return MaterialApp( //deixa os widgets mais bonitinhos (email...)
      theme: ThemeData(primarySwatch:Colors.pink), // cor do title
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => LoadingPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/perfil': (context) => PerfilPage(),
        '/cadastro': (context) => CadastroPage(),
        '/config': (context) => ConfigPage(),
        '/chat_page': (context) => ChatHomeScreen(), 
      },// tela Home

    );
  }
}