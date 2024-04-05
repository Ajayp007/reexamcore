import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reexamcore/model/model_class.dart';

import '../../utils/global.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String? path;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController txtGrid = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtStd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StudentModel data =
    ModalRoute.of(context)!.settings.arguments as StudentModel;
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundImage: FileImage(File("${data.image}")),
                  radius: 60,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name"),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${data.name}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("GrId"),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${data.grid}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Standard"),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${data.std}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
