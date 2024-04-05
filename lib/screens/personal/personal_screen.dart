import 'package:flutter/material.dart';
import 'package:reexamcore/model/model_class.dart';
import '../../utils/global.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  String? path;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtCName = TextEditingController();
  TextEditingController txtAdd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Personal Details",
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  controller: txtCName,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: " Enter The Mobile",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Mobile";
                    }
                    return null;
                  },
                  controller: txtMobile,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: " Enter The Address",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Address";
                    }
                    return null;
                  },
                  controller: txtAdd,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      Personal data = Personal(
                          cName: txtCName.text,
                          cMobile: txtMobile.text,
                          cAdd: txtAdd.text);
                      g1.personalList.add(data);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Enter The Details"),
                          duration: Duration(seconds: 3),
                        ),
                      );
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
