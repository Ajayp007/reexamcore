import 'dart:io';

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
  TextEditingController txtGrid = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtStd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students Details"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: g1.studentList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'edit',
                  arguments: g1.studentList[index])
                  .then((value) {
                setState(() {});
              });
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(
                  File("${g1.studentList[index].image}"),
                ),
              ),
              title: Text("${g1.studentList[index].name}"),
              subtitle: Text("${g1.studentList[index].std}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      alert(context, index);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        g1.studentList.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'details').then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void alert(BuildContext context, int index) {
    txtName.text = g1.studentList[index].name!;
    txtGrid.text = g1.studentList[index].grid!;
    txtStd.text = g1.studentList[index].std!;
    path = g1.studentList[index].image;

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
                                  (states) => Colors.black),
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
                      labelText: "Enter The GrId",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter The GrId";
                      }
                      return null;
                    },
                    controller: txtGrid,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Enter The Standard",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter The Standard";
                      }
                      return null;
                    },
                    controller: txtStd,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        if (path != null) {
                          StudentModel data = StudentModel(
                              name: txtName.text,
                              std: txtStd.text,
                              grid: txtGrid.text,
                              image: path);
                          g1.studentList[index] = data;
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
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
