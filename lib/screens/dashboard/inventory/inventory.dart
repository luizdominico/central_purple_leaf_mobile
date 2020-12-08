import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../main.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {

  List _data = [];

  Future<String> getInventory() async {
    String token = await storage.read(key: 'token');
    var url = "$BASE_URL/inventory";

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

  Future<String> sellProduct(String id) async {
    String token = await storage.read(key: 'token');
    var url = "$BASE_URL/product/$id/sell";

    final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    if(response.statusCode == 200){
      getInventory();
      return "Success!";
    } else {
      return null;
    }
  }

  Future<String> takeoffProduct(String id) async {
    String token = await storage.read(key: 'token');
    var url = "$BASE_URL/product/$id/takeoff";

    final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
    );

    if(response.statusCode == 200){
      getInventory();
      return "Success!";
    } else {
      return null;
    }
  }

  void chooseRaisedButtonAction(String id, bool sell){
    if(sell){
      takeoffProduct(id);
    } else {
      sellProduct(id);
    }
  }

  String formatText(bool sell){
    if(sell){
      return 'guardar'.toUpperCase();
    } else {
      return 'vender'.toUpperCase();
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
    getInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _data == null ? 0 : _data.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(
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
                              chooseRaisedButtonAction(_data[index]["id"], _data[index]["sell"])
                            },
                            child: Text(
                              formatText(_data[index]["sell"]),
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            color: Colors.yellow,
                            padding: EdgeInsets.symmetric(horizontal: 60),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.pushNamed(context, "/product")
          },
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
        )
    );
  }

}