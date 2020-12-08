import 'dart:convert';
import 'package:central_purple_leaf/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:central_purple_leaf/models/Jwt.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = '';
  String _password = '';

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<Jwt> attemptLogIn(String username, String password) async {
    var url = "$BASE_URL/login";
    var body = {
      "username": username,
      "password": password
    };

    final response = await http.post(
        url,
        body: json.encode(body),
        headers: {"Content-Type": "application/json"}
    );

    if(response.statusCode == 200){
      return Jwt.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  void handleLogin() async {
    setState(() {
      _username = _usernameController.text;
      _password = _passwordController.text;
    });

    var jwt = await attemptLogIn(_username, _password);

    if(jwt.token != null){
      await storage.write(key: "token", value: jwt.token);
      Navigator.pushNamed(context, '/dashboard');
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
              padding: EdgeInsets.only(top: 50, bottom: 50),
            ),
            Container(
              child: TextField(
                controller: _usernameController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
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
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            Container(
              child: TextField(
                controller: _passwordController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
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
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            Container(
              child: RaisedButton(
                onPressed: handleLogin,
                child: Text(
                  "Entrar".toUpperCase(),
                  style: TextStyle(
                      color: Colors.deepPurple
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 148, vertical: 13),
              ),
              margin: EdgeInsets.symmetric(vertical: 24),
            ),
            Spacer(),
            Container(
              child: InkWell(
                child: Text(
                    "Não tem uma conta? Registre-se!",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline
                    )
                ),
                onTap: () => {
                  Navigator.pushNamed(context, '/signUp')
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