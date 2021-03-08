import 'package:banking_app/screens/money_transfer.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/Modules/CustomerCard.dart';

class CustomerDetails extends StatefulWidget {
  CustomerDetails({this.name, this.phone, this.account, this.balance});

  final account;
  final name;
  final balance;
  final phone;
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomerCard(
                icon: Icon(Icons.person_rounded),
                text: "${widget.name}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomerCard(
                icon: Icon(Icons.account_box_rounded),
                text: "${widget.account}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomerCard(
                icon: Icon(Icons.phone),
                text: "${widget.phone}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomerCard(
                icon: Icon(Icons.account_balance),
                text: "${widget.balance}",
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
              child: ButtonTheme(
                height: 50.0,
                minWidth: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoneyTransfer(
                            name: "${widget.name}",
                            balance: "${widget.balance}",
                          ),
                        ));
                  },
                  elevation: 5.0,
                  child: Text(
                    "Transfer Money",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
