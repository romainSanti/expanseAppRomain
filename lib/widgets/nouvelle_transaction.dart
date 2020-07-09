import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class NouvelleTransaction extends StatefulWidget {
  final Function addTransaction;

  NouvelleTransaction(this.addTransaction);

  @override
  _NouvelleTransactionState createState() => _NouvelleTransactionState();
}

class _NouvelleTransactionState extends State<NouvelleTransaction> {
  final controlTitre = TextEditingController();
  final controlPrix = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    if (controlPrix.text.isEmpty){
      return;
    }
    final nomComplet = controlTitre.text;
    final prixComplet = double.parse(controlPrix.text);

    if (nomComplet.isEmpty || prixComplet <= 0 ||selectedDate == null) {
      return;
    }

    widget.addTransaction(nomComplet, prixComplet,selectedDate);

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2021))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            TextFormField(
              // Choix du titre ---------
              controller: controlTitre,
              onFieldSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: 'Titre',
              ),
            ),
            TextFormField(
              // Choix du prix ----------
              controller: controlPrix,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) => submitData(),
              decoration: InputDecoration(labelText: 'Prix'),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'Aucune date'
                        : 'Date : ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                  FlatButton(
                    child: Text(
                      'Choisir une date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: presentDatePicker,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Ajouter l'achat",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: submitData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
