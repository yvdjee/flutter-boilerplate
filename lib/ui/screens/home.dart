import 'package:domodar/data/local/form/schemas/authSchema.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> errors = {};

  submitForm() {
    setState(() {
      errors = authSchema.validateSync({
        "email": "iheb@mail.com",
        "password": "123",
        "options": 'C',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
