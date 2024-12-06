import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/model/entity_user.dart';
import 'package:flutter_firebase/widgets/widget_button.dart';
import 'package:flutter_firebase/widgets/widget_text.dart';
import 'package:flutter_firebase/widgets/widget_text_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/add_notes_bloc.dart';

class ScreenAddNotes extends StatefulWidget {
  const ScreenAddNotes({super.key});

  @override
  State<ScreenAddNotes> createState() => _ScreenAddNotesState();
}

class _ScreenAddNotesState extends State<ScreenAddNotes> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerMobile = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  final key = GlobalKey<FormState>();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: widgetText(
            text: "Add Notes", style: textStylePoppins(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              WidgetTextField(
                controller: controllerName,
                modelTextField:
                    ModelTextField(title: "Name", isCompulsory: true),
                hintText: "Add Name",
                enumValidator: EnumValidator.text,
              ).marginOnly(top: 20),
              WidgetTextField(
                controller: controllerEmail,
                modelTextField:
                    ModelTextField(title: "Email", isCompulsory: true),
                hintText: "Add Email",
                enumValidator: EnumValidator.email,
                enumTextInputType: EnumTextInputType.email,
              ),
              WidgetTextField(
                controller: controllerMobile,
                modelTextField:
                    ModelTextField(title: "Mobile Number", isCompulsory: true),
                hintText: "Add Mobile Number",
                enumValidator: EnumValidator.mobile,
                enumTextInputType: EnumTextInputType.mobile,
              ),
              WidgetTextField(
                controller: controllerAddress,
                modelTextField:
                    ModelTextField(title: "Address", isCompulsory: true),
                hintText: "Add Address",
                enumValidator: EnumValidator.text,
              ),
              InkWell(
                onTap: () {
                  _pickImage();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600)),
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!)
                      : const Center(
                          child: Icon(Icons.add_a_photo),
                        ),
                ),
              ),
              WidgetButton(
                  title: "Submit",
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      BlocProvider.of<AddNotesBloc>(context).add(AddNotesEvent(
                          EntityUser(
                              address: controllerAddress.text,
                              email: controllerEmail.text,
                              image: "image",
                              mobile: controllerMobile.text,
                              name: controllerName.text)));
                    }
                  }).marginOnly(top: 30)
            ],
          ).marginOnly(left: 16, right: 16),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}
