import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reexamcore/model/model_class.dart';
import '../../utils/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? path;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtCName = TextEditingController();
  TextEditingController txtAdd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: const Text(
          "Items",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'personal').then((value) {
                setState(() {});
              });
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: const Color(0xff1fba89),
      ),
      body: ListView.builder(
        itemCount: g1.itemList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff1fba89),
                  offset: Offset(
                    4.0,
                    4.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                ), //BoxShadow
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: FileImage(
                    File("${g1.itemList[index].image}"),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Item Name :- ${g1.itemList[index].name}"),
                    const SizedBox(height: 5),
                    Text("Item Quantity :- ${g1.itemList[index].qty}"),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    alert(context, index);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      g1.itemList.removeAt(index);
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1fba89),
        onPressed: () {
          Navigator.pushNamed(context, 'details').then((value) {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void alert(BuildContext context, int index) {
    txtName.text = g1.itemList[index].name!;
    txtQty.text = g1.itemList[index].qty!;
    txtPrice.text = g1.itemList[index].price!;
    path = g1.itemList[index].image;


    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      path == null
                          ? const CircleAvatar(
                              maxRadius: 60,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              ),
                            )
                          : CircleAvatar(
                              maxRadius: 60,
                              backgroundImage: FileImage(
                                File(path!),
                              ),
                            ),
                      IconButton.filled(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xff1fba89),
                          ),
                        ),
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            path = image!.path;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Enter The Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter The Name";
                      }
                      return null;
                    },
                    controller: txtName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Enter The qty",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter The qty";
                      }
                      return null;
                    },
                    controller: txtQty,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Enter The Price",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter The Price";
                      }
                      return null;
                    },
                    controller: txtPrice,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        if (path != null) {
                          ItemModel data = ItemModel(
                              name: txtName.text,
                              qty: txtQty.text,
                              price: txtPrice.text,
                              image: path);
                          g1.itemList[index] = data;
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please Choose Image"),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      decoration: BoxDecoration(
                        color: const Color(0xff1fba89),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {});
    });
  }
}
