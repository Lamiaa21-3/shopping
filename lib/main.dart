import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/my_provider.dart';
import 'package:provider/provider.dart';

import 'add_product.dart';

void main() {
  runApp(
    ChangeNotifierProvider<MyProvider>(
      create: (_) => MyProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> prolist =
        Provider.of<MyProvider>(context, listen: true).productslist;

    Widget buildPosition(title, desc, double price) {
      var descripti =
          desc.length > 20 ? desc.replacRang(20, desc.length, '....') : desc;

      return Padding(

        padding: const EdgeInsets.all(8.0),

        child: Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            width: 180,
            color: Colors.black45,
            margin: EdgeInsets.only(left: 13 0,top: 20),
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
            child: Text(
              "$title\n$descripti\n\$$price",
              style: TextStyle(fontSize: 24, color: Colors.white),
              softWrap: true,
              overflow: TextOverflow.fade,
              maxLines: 4,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(" Products "),
      ),
      body: prolist.isEmpty
          ? Center(
              child: Text(
                " No Products are added ",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 500,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemCount: prolist.length,
                  itemBuilder: (ctx, index) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                        margin: EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.file(
                                prolist[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 50,),
                            buildPosition(
                                prolist[index].title,
                                prolist[index].dsecription,
                                prolist[index].price
                            ),
                          ],
                        ),
                      )),
            ),
      floatingActionButton: Container(
        width: 180,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.teal,
        ),
        child: Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
              child: Text(
                " + Add Product ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
