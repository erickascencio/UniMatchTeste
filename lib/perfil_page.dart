import 'package:flutter/material.dart';
import 'package:unimatchteste/config_page.dart';
import 'package:unimatchteste/home_page.dart';

import 'login_page.dart';

class PerfilPage extends StatefulWidget{ // cria um estado HomePage
  @override                            // Da pra alterar enquanto roda o app
  State<PerfilPage> createState() {      // Dinamico
    return PerfilPageState();
  }
}

class PerfilPageState extends State<PerfilPage> {
  int counter = 0;
  String email = '', DatNasc = '', Uni = '', nome = '', Telefone = '',
      senha = '', ConfSenha = '', CPF = '', UniPref = '', Nu = '';
  //Null Nu = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(                   // Molda a tela para se assemelhar a um App
        centerTitle : true,
        title : Text('Perfil'),
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
                Center(
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purpleAccent.shade100,
                    ),
                  ),
                ),
                Container(height: 50,),
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
                    labelText: 'Nome de Usuário',
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
                    Uni = text;
                  },
                  decoration: InputDecoration(      // coloca borda no textfield
                    labelText: 'Gênero',
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
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                ),

                Container(height: 20,),
                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfigPage()),
                  );
                    //RETORNAR ConfSenha COMO NULL,LIMPAR O Q FOI DIGITADO
                    /**ConfSenha.replaceAllMapped( Nu, (match) => Nu,);**/
                    /**setState(() {
                        ConfSenha = null;
                        return ConfSenha.nu;
                        });**/
                }, child: Text('Editar dados cadastrais!')),
              ],
            ),
          ),
        ),
      ),

    );
  }
}