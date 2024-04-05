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
  TextEditingController txtGrid = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtStd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        centerTitle: true,
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
                      backgroundColor: Colors.black,
                      maxRadius: 60,
                      child: Icon(Icons.person),
                    )
                        : CircleAvatar(
                      backgroundImage: FileImage(File(path!)),
                      maxRadius: 60,
                    ),
                    IconButton.filled(
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          path = image!.path;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: " Enter The GrId", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter GrId";
                    }
                    return null;
                  },
                  controller: txtGrid,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: " Enter The Name", border: OutlineInputBorder()),
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
                      labelText: " Enter The Standard",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Standard";
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
                            grid: txtGrid.text,
                            name: txtName.text,
                            std: txtStd.text,
                            image: path);
                        g1.studentList.add(data);
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Save"),
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
