import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {

  String _name = '';
  String _type = "Semente";
  String _price = '';

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  Future<String> attemptProduct(String name, String type, String price) async {
    String token = await storage.read(key: 'token');
    String formatted = '';

    if(type == "Semente"){
      formatted = "seed";
    } else {
      formatted = "plant";
    }

    var url = "$BASE_URL/product";

    var body = {
      "name": name,
      "image": "http://www.url.com/image",
      "type": formatted,
      "sell": false,
      "price": num.parse(price)
    };

    final response = await http.post(
        url,
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    if(response.statusCode == 201){
      return "Sucesso!";
    } else {
      return null;
    }
  }

  void handleProduct() async {
    setState(() {
      _name = _nameController.text;
      _price = _priceController.text;
    });

    if(_name != '' && _type != '' && _price != '') {
      var message = await attemptProduct(_name, _type, _price);
      if(message != null){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text('Sucesso'),
              content: Text('O produto foi registrado.'),
              actions: [
                FlatButton(
                    child: Text('ok'.toUpperCase()),
                    color: Colors.deepPurple,
                    onPressed: () => {
                      Navigator.pushNamed(context, '/dashboard')
                    }
                ),
              ],
            )
        );
      } else {
        print('here');
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Cadastrar Produto")
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image(
                  image: NetworkImage("https://via.placeholder.com/700/F1F1F1/000000?text=Purpleleaf"),
                  width: 120,
                )
            )
          ),
          Container(
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              controller: _nameController,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
              ),
              decoration: InputDecoration(
                  hintText: 'Nome',
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.all(Radius.circular(45))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.all(Radius.circular(45))
                  )
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
          Container(
              child: DropdownButton<String>(
                value: _type,
                isExpanded: true,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurple,
                ),
                items: <String>["Semente", "Planta"].map((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.deepPurple
                          )
                      )
                  );
                }).toList(),
                onChanged: (String type) {
                  setState(() {
                    _type = type;
                  });
                }
              ),
              margin: EdgeInsets.symmetric(horizontal: 28, vertical: 5)
          ),
          Container(
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: _priceController,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
              ),
              decoration: InputDecoration(
                  hintText: 'Valor',
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.all(Radius.circular(45))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.all(Radius.circular(45))
                  )
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
          Container(
              child: RaisedButton(
                onPressed: handleProduct,
                child: Text(
                  "Cadastrar".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                color: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 136, vertical: 20),
              ),
              margin: EdgeInsets.only(top: 12)
          )
        ],
      )
    );
  }

}