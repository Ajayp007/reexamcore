import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reexamcore/model/model_class.dart';

import '../../utils/global.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? path;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  TextEditingController txtPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          "Item Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1fba89),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    path == null
                        ? const CircleAvatar(
                            backgroundColor: Color(0xff1fba89),
                            maxRadius: 60,
                            child: Icon(
                              Icons.card_travel,
                              size: 40,
                              color: Colors.white,
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(File(path!)),
                            maxRadius: 60,
                          ),
                    IconButton.filled(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          path = image!.path;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xff1fba89),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: " Enter The Name",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  controller: txtName,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: " Enter The Qty",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Qty";
                    }
                    return null;
                  },
                  controller: txtQty,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: " Enter The Price",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Price";
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
                        g1.itemList.add(data);
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
      ),
    );
  }
}
