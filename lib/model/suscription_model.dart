class Suscription {
  int id;
  String name;
  int price;
  String initialDate;
  String finalDate;
  bool activated;

  Suscription(
      this.name, this.price, this.initialDate, this.finalDate, this.activated);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "price": price,
      "initialDate": initialDate,
      "finalDate": finalDate,
      "activated": activated ? 1 : 0
    };
  }

  Suscription.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    price = map['price'];
    initialDate = map['initialDate'];
    finalDate = map['finalDate'];
    activated = map['activated'] == 1;
    id = map['id'];
  }
}
