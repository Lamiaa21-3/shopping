import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Product {
  final int id;

  final String title;

  final String dsecription;

  final double price;

  File image;

  Product({
    required this.dsecription,
    required this.price,
    required this.id,
    required this.title,
    required this.image,
  });
}

class MyProvider with ChangeNotifier {
  List <Product> productslist = [];

  late File image;

  void add({required String description, required String title, required double price}) {
    productslist.add(Product(
        dsecription: description,
        price: price,
        id: 1,
        title: title,
        image: image),
    );
    notifyListeners();
  }

   Future getImage ( ImageSource src) async
{
  final pickFile = await ImagePicker().pickImage(source  : src );
  if ( pickFile != null)
    {
       image = File( pickFile.path);
       print(" image selected ");
       notifyListeners();

    }
  else
    {
      print(" image is not existing ");
    }
}}