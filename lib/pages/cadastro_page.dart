import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../controller/UserController.dart';
import '../controller/service/CadastroService.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../model/UserModel.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  bool _allFieldsFilled = false;
  late File _image;
  DateTime datNasc = DateTime.now();


  UserController userController = UserController(UserModel(
    uid: '',
    nome: '',
    email: '',
    telefone: '',
    datNasc: DateTime.now(),
    uni: '',
    uniPref: '',
    senha: '',
   
  ));

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: userController.user.datNasc,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != userController.user.datNasc)
      setState(() {
        userController.updateDatNasc(picked);
      });
  }

  void _checkFields() {
    if (userController.user.nome.isNotEmpty &&
        userController.user.email.isNotEmpty &&
        userController.user.telefone.isNotEmpty &&
        userController.user.datNasc != null &&
        userController.user.uni.isNotEmpty &&
        userController.user.uniPref.isNotEmpty &&
        userController.user.senha.isNotEmpty &&
        userController.user.confSenha.isNotEmpty) {
      setState(() {
        _allFieldsFilled = true;
      });
    } else {
      setState(() {
        _allFieldsFilled = false;
      });
    }
  }

  List<String> listItems = [
    "Selecione sua Universidade",
    "Unicentro - Cedeteg",
    "Unicentro - Santa Cruz",
    "Campo Real",
    "UTFPR",
    "Guairacá",
    "Universidade Guarapuava"
  ];
  String selectedValue = "Selecione sua Universidade";

  Widget buildDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String value in listItems) {
      DropdownMenuItem<String> item = DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
      dropdownItems.add(item);
    }

    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
          userController.updateUni(newValue);
          _checkFields();
        });
      },
      items: dropdownItems,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      dropdownColor: Colors.white,
      underline: Container(
        height: 1,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  Widget buildMultiSelectButton() {
    List<String> universityOptions = [
      "Unicentro - Cedeteg",
      "Unicentro - Santa Cruz",
      "Campo Real",
      "UTFPR",
      "Guairacá",
      "Universidade Guarapuava"
    ];

    List<String> selectedUniversities = [];

    return MultiSelectDialogField(
      items: universityOptions
          .map((university) => MultiSelectItem<String>(university, university))
          .toList(),
      title: const Text(
        "Universidades",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      selectedItemsTextStyle: const TextStyle(color: Colors.blue),
      buttonText: const Text(
        "Selecione",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      onConfirm: (List<String> selectedValues) {
        setState(() {
          selectedUniversities = selectedValues;
          userController.updateUniPref(selectedValues.join(", "));
          _checkFields();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cadastro',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextField(
                onChanged: (text) {
                  userController.updateNome(text);
                  _checkFields();
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (text) {
                  userController.updateEmail(text);
                  _checkFields();
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (text) {
                  userController.updateTelefone(text);
                  _checkFields();
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text(
                  'Selecionar Data de Nascimento',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Selecione sua universidade',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              buildDropdownButton(),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              const Text(
                'Universidades Preferidas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildMultiSelectButton(),
              const SizedBox(height: 16),
              TextField(
                onChanged: (text) {
                  userController.updateSenha(text);
                  _checkFields();
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (text) {
                  userController.updateConfSenha(text);
                  _checkFields();
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _allFieldsFilled
                    ? () async {
                        CadastroService cadastroService =
                            CadastroService(userController.user);
                        await cadastroService.registerUser();
                      }
                    : null,
                child: const Icon(Icons.done),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
