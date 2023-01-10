import 'dart:convert';

import '../models/product.dart';
import 'package:http/http.dart' as http;

class ApiCall{

  Future<List<Product>> get() async{
    var url = Uri.parse("http://api.nstack.in/v1/todos?page=1&limit=20");

    var response = await http.get(url);
    if (response.statusCode == 200){
      final jsonDecoded = jsonDecode(response.body);
      final List<dynamic> decodedList = jsonDecoded["items"] as List;
      final List<Product> data = decodedList.map((item) {
        return Product.fromJson(item);
      }).toList();

      return data;

    }
    else{
      throw Exception("Cannot fetch Data");
    }
  }

  Future<bool> post({required var title, required var description}) async {
    // final title = _titleController.text;
    // final desc = _descController.text;

    var body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    var url = Uri.parse("http://api.nstack.in/v1/todos");

    var jsonEncoded = jsonEncode(body);

    var response = await http.post(
        url,
        body: jsonEncoded,
        headers: {
          "Content-Type": 'application/json'
        }
    );

    if (response.statusCode == 201){
      return true;
    }
    else{
      return false;
    }

  }

  Future<bool> update({required var title, required var description, required id}) async {
    var body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    var url = Uri.parse("http://api.nstack.in/v1/todos/$id");
    var jsonEncoded = jsonEncode(body);
    var response = await http.put(
        url,
        body: jsonEncoded,
        headers: {
          "Content-Type": 'application/json'
        }
    );

    if (response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool?> delete (String id) async {
    var url = Uri.parse("http://api.nstack.in/v1/todos/$id");
    final response = await http.delete(url);
    if (response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }

}