import 'package:crud_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';

import '../helper/api_call.dart';
import '../models/product.dart';
import '../screens/create_page.dart';
import 'navigate.dart';

class ShowProduct extends StatefulWidget {
  const ShowProduct({Key? key}) : super(key: key);

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {

  ApiCall _getData = ApiCall();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _getData.get();
        });
      },
      child: FutureBuilder<List<Product>>(
        future: _getData.get(),
        builder: (context, AsyncSnapshot<List<Product>> snapshot){
          if (snapshot.hasData){
            if (snapshot.data!.isEmpty){
              return const Center(
                child: Text("No Data"),
              );
            }
            else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final id = snapshot.data![index].id;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(snapshot.data![index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(snapshot.data![index].description,
                                style: const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                          PopupMenuButton(
                              onSelected: (value) async {
                                if (value == "edit") {
                                  navigate(
                                    context,
                                    CreatePage(
                                      headingText: "Edit",
                                      buttonText: "Update",
                                      id: snapshot.data![index].id,
                                      title: snapshot.data![index].title,
                                      description: snapshot.data![index].description,
                                    ),
                                  );
                                }
                                else if (value == "delete") {
                                  var delete = await _getData.delete(id);
                                  if (delete == true){
                                    setState(() {
                                      _getData.get();
                                    });
                                  }
                                  else{
                                    showSnackBar(context, "Deletion Failed", Colors.red);
                                  }
                                }
                              },
                              itemBuilder: (context) {
                                return const [
                                  PopupMenuItem(
                                    value: "edit", child: Text("Edit"),),
                                  PopupMenuItem(value: "delete",
                                    child: Text("Delete"),),
                                ];
                              }),
                        ],
                      ),
                    );
                  }
              );
            }
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}
