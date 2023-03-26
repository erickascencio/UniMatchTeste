import 'package:flutter/material.dart';
import 'package:unimatchteste/cadastro_page.dart';
import 'package:unimatchteste/config_page.dart';
import 'package:unimatchteste/loading_page.dart';
import 'package:unimatchteste/perfil_page.dart';

import 'home_page.dart';
import 'login_page.dart';

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
      },// tela Home

    );
    /**return Container(
        child: Center(
        child: Text(
        title,
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        ),
        );**/
  }
}