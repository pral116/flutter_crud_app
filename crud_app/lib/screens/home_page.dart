
import 'package:crud_app/helper/api_call.dart';
import 'package:crud_app/widgets/navigate.dart';
import 'package:crud_app/widgets/show_products.dart';
import 'package:flutter/material.dart';

import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD App"),
      ),

      body: Container(
        child: const ShowProduct(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await navigate(context,
            const CreatePage(
                headingText: "Add",
                buttonText: "Create"
            ),
          );
        },
        child: const Text("Create"),
      ),
    );
  }

}
