import 'package:central_purple_leaf/models/Comment.dart';

class Product {
  final String id;
  final String name;
  final String type;
  final String image;
  final bool sell;
  final num price;
  final List comments;

  Product({this.id, this.name, this.type, this.image, this.sell, this.price, this.comments});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        image: json['image'],
        sell: json['sell'],
        price: json['price'],
        comments: json['comments']
    );
  }
}