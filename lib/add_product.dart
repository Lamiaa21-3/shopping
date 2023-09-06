

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_product/main.dart';
import 'package:my_product/my_provider.dart';
import 'package:provider/provider.dart';



class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key);
  var titleController = TextEditingController()
    ..text = " ";
  var descriptionController = TextEditingController()
    ..text = "";
  var priceController = TextEditingController()
    ..text = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product "),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: "Title ", hintText: " Add Title"),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Description ", hintText: " Add Description"),
                controller: descriptionController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Price  ", hintText: " Add Price"),
                controller: priceController,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Widget ad = AlertDialog(
                      title: Text(" Choise Picture from"),
                      content: Container(
                        height: 150,
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.black,
                            ),
                            Builder(
                                builder: (innerContext) =>
                                    Container(
                                      color: Colors.teal,
                                      child: ListTile(
                                        leading: Icon(Icons.image),
                                        title: Text("Callery"),
                                        onTap: () {
                                          context
                                              .read<MyProvider>()
                                              .getImage(ImageSource.gallery);
                                          Navigator.of(innerContext).pop();
                                        },
                                      ),
                                    )),
                            SizedBox(
                              height: 10,
                            ),
                            Builder(
                                builder: (innerContext) =>
                                    Container(
                                      color: Colors.teal,
                                      child: ListTile(
                                        leading: Icon(Icons.image),
                                        title: Text("Camera"),
                                        onTap: () {
                                          context
                                              .read<MyProvider>()
                                              .getImage(ImageSource.camera);
                                          Navigator.of(innerContext).pop();
                                        },
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    );
                    showDialog(context: context, builder: (_) => ad);
                  },
                  child: Text(" Choise Image "),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Consumer<MyProvider>(
                builder: (ctx, value, child) =>
                    ElevatedButton(
                      onPressed: () async {
                        if (titleController.text == " " ||
                            descriptionController.text == "" ||
                            priceController.text == "") {
                          Fluttertoast.showToast(
                            msg: " PLease enter all Dialds ",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }

                        // } else if (_image == null) {
                        //   Fluttertoast.showToast(
                        //       msg: "Please select image ",
                        //       toastLength: Toast.LENGTH_SHORT);
                        // }
                        else {
                          try {
                            value.add(description: descriptionController.text,
                              title: titleController.text,
                              price: double.parse(priceController.text),);
                            await Navigator.pushReplacement(ctx,
                                MaterialPageRoute(
                                    builder: (ctx) => MyHomePage()));
                          }
                          catch (e) {
                            Fluttertoast.showToast(
                                msg: "please enter valid price ");
                            print(e);
                          }
                        }
                      },
                      child: Text(" Add Product "),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}