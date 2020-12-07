import 'dart:convert';
import 'package:central_purple_leaf/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _username = '';
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _birthDate = '';

  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<User> attemptSignUp(String username, String fullname, String email, String password, String birthdate) async {
    var url = "$BASE_URL/users";
    var body = {
      "username": username,
      "fullname": fullname,
      "email": email,
      "password": password,
      "birthdate": birthdate
    };

    final response = await http.post(
        url,
        body: json.encode(body),
        headers: {"Content-Type": "application/json"}
    );

    if(response.statusCode == 201){
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  void handleSignUp() async {
    setState(() {
      _username = _usernameController.text;
      _fullName = _fullNameController.text;
      _email = _emailController.text;
      _password = _passwordController.text;
    });

    if(_username != '' && _fullName != '' && _email != '' && _password != '' &&_birthDate != ''){
      var user = await attemptSignUp(_username, _fullName, _email, _password, _birthDate);
      if(user != null){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text('Sucesso'),
              content: Text('Parabéns $_username! Você está registrado.'),
              actions: [
                FlatButton(
                    child: Text('ok'.toUpperCase()),
                    color: Colors.deepPurple,
                    onPressed: () => {
                      Navigator.pushNamed(context, '/login')
                    }
                ),
              ],
            )
        );
      }
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text('Alerta'),
            content: Text('Por favor verifique os campos preenchidos.'),
            actions: [
              FlatButton(
                  child: Text('ok'.toUpperCase()),
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(45))
                  ),
                  onPressed: () => {
                    Navigator.pop(context)
                  }
              ),
            ],
          )
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        resizeToAvoidBottomInset: false,
        body: Column (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/logo.png'),
              padding: EdgeInsets.only(top: 20, bottom: 20),
            ),
            Container(
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                controller: _usernameController,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                    hintText: 'Usuário',
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(45))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(45))
                    )
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            Container(
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                controller: _fullNameController,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                    hintText: 'Nome',
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(45))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(45))
                    )
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            Container(
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(45))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(45))
                    )
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            Container(
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                controller: _passwordController,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Senha',
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    )
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            Container(
                child: FlatButton(
                  onPressed: () => {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1901),
                      lastDate: DateTime(2101),
                    ).then((date) => {
                      setState((){
                        if(date != null) {
                          _birthDate = DateFormat('yyyy-MM-dd').format(date);
                        } else {
                          _birthDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                        }
                      })
                    })
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Data de Nascimento",
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(
                          CupertinoIcons.calendar,
                          color: Colors.grey,
                      )
                    ]
                  )
                ),
              padding: EdgeInsets.symmetric(horizontal: 100)
            ),
            Container(
              child: RaisedButton(
                onPressed: handleSignUp,
                child: Text(
                  "Registrar".toUpperCase(),
                  style: TextStyle(
                      color: Colors.deepPurple
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 136, vertical: 20),
              ),
              margin:EdgeInsets.symmetric(horizontal: 20, vertical: 5)
            ),
            Spacer(),
            Container(
              child: InkWell(
                child: Text(
                    "Já tem uma conta? Entre!",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline
                    )
                ),
                onTap: () => {
                  Navigator.pushNamed(context, '/login')
                },
              ),
              margin: EdgeInsets.all(30),
            )
          ],
        ),
      ),
    );
  }
}