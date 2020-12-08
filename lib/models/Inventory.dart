class Inventory {
  final String id;
  final String name;
  final String type;
  final String image;
  final bool sell;
  final num price;

  Inventory({this.id, this.name, this.type, this.image, this.sell, this.price});

  factory Inventory.fromJson(Map<String, dynamic> json){
    return Inventory(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      image: json['image'],
      sell: json['sell'],
      price: json['price']
    );
  }

}