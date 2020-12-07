import 'package:flutter/material.dart';
import '../../../main.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: RaisedButton(
            onPressed: () async => {
              await storage.delete(key: 'token'),
              Navigator.pushNamed(context, '/login')
            },
            child: Text(
              "sair".toUpperCase(),
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            color: Colors.redAccent,
          )
        )
      ]
    );
  }

}