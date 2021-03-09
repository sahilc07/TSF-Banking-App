import 'package:banking_app/screens/all_customers.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:banking_app/Modules/GradientButton.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(
          'The Sparks Bank',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Icon(
              Icons.account_balance,
              color: Colors.lightBlue,
              size: 250.0,
            ),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GradientButton(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllUsers()));
                },
                text: "View All Customers",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
