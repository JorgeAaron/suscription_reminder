import 'package:flutter/material.dart';
import 'package:suscription_reminder_v2/model/suscription_model.dart';
import 'package:suscription_reminder_v2/data/db.dart';

// ignore: must_be_immutable
class AddSuscription extends StatefulWidget {
  AddSuscription({Key key}) : super(key: key);

  @override
  _AddSuscriptionState createState() => _AddSuscriptionState();
}

class _AddSuscriptionState extends State<AddSuscription> {
  @override
  void initState() {
    db.initDB();
    super.initState();
  }

  SuscriptionDatabase db = SuscriptionDatabase();

  String name;
  int price;
  String initialDate;
  String finalDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          Text('Nombre de la suscripcion:'),
          TextField(
            onChanged: (text) {
              name = text;
            },
          ),
          Text('Precio de la suscripcion:'),
          TextField(
            onChanged: (text) {
              price = int.parse(text);
            },
          ),
          Text('Fecha inicial:'),
          TextField(
            onChanged: (text) {
              initialDate = text;
            },
          ),
          Text('Fecha final:'),
          TextField(
            onChanged: (text) {
              finalDate = text;
            },
          ),
          FlatButton(
              color: Colors.black,
              onPressed: () {
                var suscription =
                    Suscription(name, price, initialDate, finalDate, false);
                db.insert(suscription);
              },
              child: null),
          FlatButton(
            child: null,
            color: Colors.yellow,
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/',
              );
            },
          )
        ],
      ),
    );
  }
}
