import 'package:flutter/material.dart';

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
          ),
        ),
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
