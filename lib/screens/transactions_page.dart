import 'package:banking_app/Modules/CustomerCard.dart';
import 'package:banking_app/screens/all_customers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:banking_app/Modules/GradientButton.dart';

class Transactions extends StatefulWidget {
  Transactions(
      {this.customerName, this.receiverName, this.account, this.balance});
  final customerName;
  final receiverName;
  final account;
  final balance;
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  Future getUsers() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('users').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(
          "Transaction Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
      ),
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          } else {
            return StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: Colors.blue,
                          size: 100.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(
                            "Rs ${widget.balance}.00",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Payment Successful",
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomerCard(
                          text: "From: ${widget.customerName}",
                          icon: Icon(Icons.person_rounded),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomerCard(
                          text: "To: ${widget.receiverName}",
                          icon: Icon(Icons.person_rounded),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomerCard(
                          text: "To A/C: ${widget.account}",
                          icon: Icon(Icons.account_circle),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomerCard(
                          text: "Amount: ${widget.balance}",
                          icon: Icon(Icons.account_balance_wallet_rounded),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GradientButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllUsers(
                                      balance: "${widget.balance}",
                                      customerName: "${widget.customerName}",
                                      receiverName: "${widget.receiverName}",
                                    ),
                                  ),
                                );
                              },
                              text: "Done",
                            )),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
