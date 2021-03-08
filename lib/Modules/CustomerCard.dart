import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  CustomerCard({this.icon, this.text, this.cardColor, this.textColor});

  final String text;
  final Icon icon;
  final Color cardColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 30.0,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
