import 'package:crud_app/helper/api_call.dart';
import 'package:flutter/material.dart';

import '../widgets/snackbar.dart';


class CreatePage extends StatefulWidget {
  final String headingText;
  final String buttonText;
  final String? id;
  final String? title;
  final String? description;
  const CreatePage({Key? key,
    required this.headingText, required this.buttonText,
    this.title, this.description, this.id
  }) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.title != null && widget.description != null){
      _titleController.text = widget.title.toString();
      _descController.text = widget.description.toString();
    }
  }

  ApiCall _apiCall = ApiCall();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),

      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.headingText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: _descController,
              minLines: 5,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async {
                if (widget.id != null){
                  var update = await _apiCall.update(
                      title: _titleController.text,
                      description: _descController.text,
                      id: widget.id
                  );
                  if (update == true){
                    showSnackBar(context, "Updated", Colors.green);
                  }
                  else{
                    showSnackBar(context, "Failed", Colors.red);
                  }
                }
                else{
                  var create = await _apiCall.post(
                      title: _titleController.text,
                      description: _descController.text
                  );
                  if (create == true){
                    _titleController.text = "";
                    _descController.text = "";
                    showSnackBar(context, "Created", Colors.green);
                  }
                  else{
                    showSnackBar(context, "Failed", Colors.red);
                  }
                }
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
              ),
              child: Center(child: Text(widget.buttonText),),
            ),
          ],
        ),
      ),
    );
  }

}
