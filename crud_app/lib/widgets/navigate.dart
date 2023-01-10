import 'package:flutter/material.dart';

Future<void> navigate(BuildContext context, var page) async {
  Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return page;
      }),
  );
}