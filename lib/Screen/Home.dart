import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHive extends StatelessWidget{
  final String email;
  HomeHive({
    Key?key,
    required this.email
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('WELCOME  $email')),
    );
  }

}