import 'package:central_purple_leaf/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class Details extends StatefulWidget {

  final String id;
  const Details({Key key, this.id}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Product _product;
  String _comment;

  final _commentController = TextEditingController();

  Future<String> getDetails(String id) async {
    String token = await storage.read(key: 'token');
    var url = "$BASE_URL/product/$id";

    final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    if(response.statusCode == 200){
      this.setState(() {
        _product = Product.fromJson(json.decode(response.body));
      });
      return "Sucesso!";
    } else {
      return null;
    }
  }

  Future<String> attemptComment(String id, String comment) async {
    String token = await storage.read(key: 'token');

    var url = "$BASE_URL/comment/$id";

    var body = {
      "message": comment
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

  void handleComment(String id) async {
    setState(() {
      _comment = _commentController.text;
    });

    if(id != '' && _comment != '' ) {
      var message = await attemptComment(id, _comment);
      if(message != null){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text('Sucesso'),
              content: Text("O comentário foi adicionado."),
              actions: [
                FlatButton(
                    child: Text('ok'.toUpperCase()),
                    color: Colors.deepPurple,
                    onPressed: () => {
                      Navigator.pop(context)
                    }
                ),
              ],
            )
        );
        _commentController.clear();
        getDetails(id);
      }
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text('Alerta'),
            content: Text('Por favor verifique se o campo de comentário foi preenchido.'),
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

  String formatType(String type){
    if(type == "seed"){
      return 'Semente';
    } else {
      return 'Planta';
    }
  }

  @override
  void initState() {
    super.initState();
    getDetails(widget.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Detalhes")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _product == null ? Center(child: CircularProgressIndicator(backgroundColor: Colors.deepPurple)) : Card (
            key: Key(_product.id),
            elevation: 5,
            shadowColor: Colors.deepPurple,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              height: 160,
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 30),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image(
                            image: NetworkImage("https://via.placeholder.com/400/F1F1F1/000000?text=Purpleleaf"),
                            width: 120,
                          )
                      )
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: Text(
                                _product.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                )
                            )
                        ),
                        Text(formatType(_product.type)),
                        Text(
                            "R\$ " + _product.price.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              controller: _commentController,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
              ),
              decoration: InputDecoration(
                  hintText: 'Comentário',
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
            margin: EdgeInsets.only(left: 20, right: 20, top: 28),
          ),
          Container(
              child: RaisedButton(
                onPressed: () => {handleComment(_product.id)},
                child: Text(
                  "Comentar".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                color: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 139, vertical: 20),
              ),
              margin: EdgeInsets.only(top: 12)
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: _product == null ? SizedBox.shrink() : ListView.builder(
                  itemCount: _product.comments == null ? 0 : _product.comments.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                            child: Text(
                                _product.comments[index]["message"],
                                style: TextStyle(
                                    fontSize: 16
                                )
                            )
                        )
                    );
                  }
              )
            )
          )
        ],
      )
    );
  }
}