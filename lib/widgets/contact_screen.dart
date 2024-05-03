import 'dart:io';
import 'package:contact_form/controller/contact_controller.dart';
import 'package:contact_form/models/contact.dart';
import 'package:contact_form/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  File? _image;
  final _imagePicker = ImagePicker();

  final formkey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noTelpController = TextEditingController();

  Future<void> getImage() async {
    final XFile? pickerFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickerFile != null) {
        _image = File(pickerFile.path);
      } else {
        print("Please Input Image First!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Name", hintText: "Enter Contact Name"),
                  controller: _namaController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email", hintText: "Enter Contact Email"),
                  controller: _emailController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Address", hintText: "Enter Contact Address"),
                  controller: _alamatController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Number", hintText: "Enter Contact Number"),
                  controller: _noTelpController,
                ),
              ),
              _image == null
                  ? const Text('No Image Selected.')
                  : Image.file(_image!),
              ElevatedButton(
                  onPressed: getImage,
                  child: const Text("Choose an image"),
                ),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          var result = await ContactController.addPerson(
                              Contact(
                                  name: _namaController.text,
                                  email: _emailController.text,
                                  address: _alamatController.text,
                                  number: _noTelpController.text,
                                  photo: _image!.path),
                              _image);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result['message'])),
                          );

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false);
                        }
                      },
                      child: const Text("Submit")),
                )
            ],
          ),
        ));
  }
}
