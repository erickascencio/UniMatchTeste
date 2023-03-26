import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unimatchteste/Notificacao_page.dart';

import 'home_page.dart';
import 'login_page.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  int counter = 0;
  String email = '', DatNasc = '', Uni = '', nome = '', Telefone = '',
      senha = '', ConfSenha = '', CPF = '', UniPref = '', Nu = '';
  //Null Nu = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(                   // Molda a tela para se assemelhar a um App
        centerTitle : true,
        title : Text('Informações Pessoais'),
      ),
      body: SingleChildScrollView(  //permite dar Scroll na tela enquanto digita
        child: SizedBox(            //Box de Login
          width: MediaQuery.of(context).size.width, // delimita o tamanho (X,Y)
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),  //Distancia da borda do celular
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (text){
                    print(text);
                    nome = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(height: 10,),
                TextField(
                  onChanged: (text){
                    print(text);
                    email = text;
                  },
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                /**Container(height: 10,),
                    TextField(
                    onChanged: (text){
                    print(text);
                    CPF = text;
                    },
                    decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'CPF',
                    border: OutlineInputBorder(),
                    ),
                    ),**/
                Container(height: 10,),
                TextField(
                  onChanged: (text){
                    print(text);
                    Telefone = text;
                  },
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(height: 10,),
                TextField(
                  onChanged: (text){
                    print(text);
                    DatNasc = text;
                  },
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Data de Nascimento',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(height: 10,),
                TextField(
                  onChanged: (text){
                    print(text);
                    Uni = text;
                  },
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Universidade',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(height: 10,),
                TextField(
                  onChanged: (text){
                    print(text);
                    UniPref = text;
                  },
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Universidade que mais lhe agrada',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(height: 10,),
                TextField(
                  onChanged: (text){
                    print(text);
                    senha = text;
                  },
                  obscureText:  true,  //deixa senha nao visivel
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(height: 10,),
                TextField(
                  onChanged: (text){
                    print(text);
                    ConfSenha = text;
                  },
                  obscureText:  true,  //deixa senha nao visivel
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Confirmar senha',
                    border: OutlineInputBorder(),
                  ),
                ),

                Container(height: 20,),
                ElevatedButton(onPressed: (){
                  if(senha == ConfSenha){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }else{
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NotificacaoSenhaPage()),
                    );
                  }
                  //RETORNAR ConfSenha COMO NULL,LIMPAR O Q FOI DIGITADO
                  /**ConfSenha.replaceAllMapped( Nu, (match) => Nu,);**/
                  /**setState(() {
                      ConfSenha = null;
                      return ConfSenha.nu;
                      });**/
                }, child: Text('Confirmar Alterações!')),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

/**import 'package:flutter/material.dart';

    class LoginPage extends StatefulWidget{ // cria um estado HomePage
    @override                            // Da pra alterar enquanto roda o app
    State<LoginPage> createState() {      // Dinamico
    return LoginPageState();
    }
    }

    class LoginPageState extends State<LoginPage>{
    int counter = 0;

    @override
    Widget build(BuildContext context) {
    return Scaffold(                      // Tela branca no fundo
    appBar: AppBar(                   // Molda a tela para se assemelhar a um App
    title: Text('UniMatch'),
    ),
    body: Container(
    height: 800,
    width: 500,
    color: Colors.pinkAccent,
    child: Align(                     // alinhamento do container
    alignment: Alignment.center, //Essas duas linhas podem ser subs por center
    child: Container(
    child : Center(
    child: Text('UNIMATCH',
    style: TextStyle(color: Colors.white, fontSize: 20.0)),
    ),
    height: 200,
    width: 200,
    color: Colors.pink,
    ),
    ),
    ),
    floatingActionButton: FloatingActionButton( // botao flutuante dir/baixo
    child: Icon(Icons.add), // icone do botao
    onPressed: () {
    setState(() { //muda o estado a cada clicada na tela
    counter++;
    print(counter); // printa no terminal
    });
    } ,
    ),
    );
    }

    }**/