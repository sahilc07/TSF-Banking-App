import 'package:banking_app/Modules/CustomerCard.dart';
import 'package:banking_app/screens/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:banking_app/Modules/TransferField.dart';
import 'package:banking_app/Modules/GradientButton.dart';

class MoneyTransfer extends StatefulWidget {
  MoneyTransfer({this.name, this.balance});
  final name;
  final balance;

  @override
  _MoneyTransferState createState() => _MoneyTransferState();
}

class _MoneyTransferState extends State<MoneyTransfer> {
  String selectedUser;
  TextEditingController _accountController = TextEditingController();
  TextEditingController _balanceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(
          "Money Transfer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomerCard(
                icon: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                ),
                text: "${widget.name}",
                cardColor: Colors.blue,
                textColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  List<DropdownMenuItem> users = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    users.add(DropdownMenuItem(
                      child: Text(
                        snap.data()["name"],
                        style: TextStyle(fontSize: 17.0),
                      ),
                      value: "${snap.data()["name"]}",
                    ));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: double.infinity,
                      child: DropdownButton(
                        items: users,
                        onChanged: (user) {
                          setState(() {
                            selectedUser = user;
                          });
                        },
                        value: selectedUser,
                        hint: Text(
                          "Select Receiver's Name",
                          style: TextStyle(fontSize: 17.0),
                        ),
                        isExpanded: true,
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TransferField(
                  controller: _accountController,
                  hint: "To: Account Number",
                  icon: Icon(
                    Icons.account_circle,
                  ),
                  val: "Account Number cannot be empty"),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TransferField(
                controller: _balanceController,
                hint: "Enter Amount",
                icon: Icon(
                  Icons.account_balance_wallet,
                ),
                val: "Enter some amount to send",
              ),
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
                      builder: (context) => Transactions(
                        customerName: "${widget.name}",
                        receiverName: selectedUser,
                        balance: _balanceController.text,
                        account: _accountController.text,
                      ),
                    ),
                  );
                },
                text: "Transfer",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
