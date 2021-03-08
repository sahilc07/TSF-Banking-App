import 'package:banking_app/Modules/CustomerCard.dart';
import 'package:banking_app/screens/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      appBar: AppBar(
        title: Text(
          "Money Transfer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                    Icons.person_rounded,
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
                        builder: (context) => Transactions(
                          customerName: widget.name,
                          receiverName: selectedUser,
                          account: int.parse(_accountController.text),
                          balance: int.parse(_balanceController.text),
                        ),
                      ),
                    );
                  },
                  elevation: 5.0,
                  child: Text(
                    "Transfer",
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

class TransferField extends StatelessWidget {
  TransferField({this.controller, this.hint, this.icon, this.val});

  final TextEditingController controller;
  final String hint;
  final Icon icon;
  final String val;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: icon,
        hintText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.blue,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return val;
        } else {
          return null;
        }
      },
    );
  }
}
