import 'package:flutter/material.dart';
import 'package:unimatchteste/login_page.dart';
import 'package:unimatchteste/perfil_page.dart';
import 'package:unimatchteste/cadastro_page.dart';

class HomePage extends StatefulWidget {
  // cria um estado HomePage
  @override // Da pra alterar enquanto roda o app
  State<HomePage> createState() {
    // Dinamico
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;
  late String usuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tela branca no fundo
      appBar: AppBar(
        // Molda a tela para se assemelhar a um App
        centerTitle: true,
        title: Text('UniMatch'),
        actions: [
          FilledButton.icon(
            //Cria o icone chat
            icon: Icon(Icons.chat_rounded),
            label: Container(
              color: Colors.white,
            ),
            onPressed: () {
              //REDIRECIONA P/ TELA DE PERFIL, MUDAR P/ TELA DE CHAT
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
          mainAxisAlignment: MainAxisAlignment.center, //posicao de tudo
          //crossAxisAlignment: CrossAxisAlignment.center, // posicao cruz
          children: [
            Align(
              heightFactor: 1.1, //MOVE SÓ O Q ESTÁ ABAIXO DO ALIGN
              child: SizedBox(
                child: Container(
                  height: 562,
                  width: 340,
                  color: Colors.white,
                ),
              ),
              //child: Text('Contador: $counter')
            ),
            //Container(height: 50,),  // espacamento altura
            //CustomSwitch(),

            Row(
              // linha/oposto da Column

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    
                      child: IconButton(
                        icon: Image.asset('assets/deslike.png'),
                        onPressed: () {
                          // código a ser executado quando o botão for pressionado
                        },
                      ),
                    ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.info_outline),
                    color: Colors.black,
                    onPressed: () {
                      // Adicione aqui o que deve acontecer quando o botão for pressionado
                    },
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: FilledButton.icon(
                            icon: Icon(
                              Icons.check_circle,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: Container(),
                            onPressed: () {
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),

      drawer: Drawer(
        //CRIA MENU NA TELA PRINCIPAL, 3 BARRINHAS
        child: ListView(
          children: [
            DrawerHeader(
              //CABECALHO DO MENU
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
                //REDIRECIONA PRO WIDGET NOMEADO NO app_widget
                Navigator.of(context).pushNamed('/perfil');
                /**Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerfilPage()),
                );**/
                // Update the state of the app
                // ...
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Configurações',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                //REDIRECIONA PRO WIDGET NOMEADO NO app_widget
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
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
