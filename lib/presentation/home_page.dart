import 'package:flutter/material.dart';
import 'package:suscription_reminder_v2/data/db.dart';
import 'package:suscription_reminder_v2/model/suscription_model.dart';

class MyHomePage extends StatefulWidget {
  final String title = "App";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SuscriptionDatabase db = SuscriptionDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: db.initDB(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _showList(context);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/add',
            );
          },
          tooltip: 'Add',
          child: Icon(Icons.add),
        ));
  }

  _showList(BuildContext context) {
    return FutureBuilder(
        future: db.getAllSuscriptions(),
        builder: (context, AsyncSnapshot<List<Suscription>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                for (Suscription suscription in snapshot.data)
                  ListTile(
                    leading: Text(suscription.price.toString()),
                    title: Text(suscription.name),
                    subtitle: Text(suscription.initialDate +
                        '---' +
                        suscription.finalDate),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteSuscription(suscription);
                          setState(() {});
                        }),
                  )
              ],
            );
          } else {
            return Center(
              child: Text("Add Suscriptions"),
            );
          }
        });
  }

  _UpdateSuscription(Suscription suscription) async {
    suscription.activated = !suscription.activated;
    await db.updateSuscription(suscription);
    setState(() async {});
  }

  _deleteSuscription(Suscription suscription) async {
    await db.deleteSuscription(suscription);
  }
}
