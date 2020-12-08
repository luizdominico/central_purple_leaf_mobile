import 'package:central_purple_leaf/screens/details/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../main.dart';

class Catalogue extends StatefulWidget {
  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {

  List _data = [];

  Future<String> getProducts() async {
    String token = await storage.read(key: 'token');
    var url = "$BASE_URL/products";

    final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    if(response.statusCode == 200){
      this.setState(() {
        _data = json.decode(response.body);
      });
      return "Success!";
    } else {
      return null;
    }
  }

  Future<String> buyProduct(String id) async {
    String token = await storage.read(key: 'token');
    var url = "$BASE_URL/product/$id/buy";

    final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    if(response.statusCode == 200){
      getProducts();
      return "Success!";
    } else {
      return null;
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
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _data == null ? 0 : _data.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: () async => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(
                          id: _data[index]["id"]
                      )
                  )
              )
            },
            child: Card(
              key: Key(_data[index]["id"]),
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
                                  _data[index]["name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  )
                              )
                          ),
                          Text(formatType(_data[index]["type"])),
                          Text(
                              "R\$ " + _data[index]["price"].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          RaisedButton(
                            onPressed: () => {
                              buyProduct(_data[index]["id"]),
                            },
                            child: Text(
                              "Comprar".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            color: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 53),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          );
        }
    );
  }

}