import 'dart:io';
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
            ],
          ),
        ));
  }
}
