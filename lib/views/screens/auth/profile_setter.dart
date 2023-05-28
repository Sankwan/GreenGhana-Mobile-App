import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/form_fields_controller.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/views/widgets/edit_profile_pic.dart';

class ProfileSetter extends StatefulWidget {
  const ProfileSetter({super.key});

  @override
  State<ProfileSetter> createState() => _ProfileSetterState();
}

class _ProfileSetterState extends State<ProfileSetter> {
  var firebaseServices = FirebaseServices();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  String img = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        children: [
          const Text(
            'Add name and \nprofile image ',
            textAlign: TextAlign.center,
            // style: titleTextBrown,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
          ),
          InkWell(
              onTap: () async {
                var imgUrl = File('user/${mAuth.currentUser!.uid}');
                Reference ref =
                    storage.ref().child('user/${mAuth.currentUser!.uid}');
                await ref.putFile(imgUrl).whenComplete(() async {
                  await ref.getDownloadURL().then((value) {
                    setState(() {
                      img = value;
                    });
                  });
                });
              },
              child: ProfilePic(imgUrl: img)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
          ),
          Form(
            key: _formKey,
            child: textFormField(nameController),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  // style: buttonStyle1,
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   firebaseServices.updateName(nameController.text);
                    //   nextNavRemoveHistory(
                    //     context,
                    //     HomePage(),
                    //   );
                    // }
                  },
                  child: const Text(
                    'Save',
                    // style: headerTextWhite,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
