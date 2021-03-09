import 'package:banking_app/screens/money_transfer.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/Modules/CustomerCard.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:banking_app/Modules/GradientButton.dart';

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
      appBar: NewGradientAppBar(
        title: Text(
          'Customer Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
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
              child: GradientButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoneyTransfer(
                        name: "${widget.name}",
                        balance: "${widget.balance}",
                      ),
                    ),
                  );
                },
                text: "Money Transfer",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
