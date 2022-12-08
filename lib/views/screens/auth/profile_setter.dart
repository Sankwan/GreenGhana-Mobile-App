import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/form_fields_controller.dart';
import 'package:instagram_aa/views/screens/homepage.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
// import 'package:tiktok_yt/constants.dart';
// import 'package:tiktok_yt/controller/firebase_services.dart';
// import 'package:tiktok_yt/view/widgets/custom_widget.dart';

class ProfileSetter extends StatefulWidget {
  const ProfileSetter({super.key});

  @override
  State<ProfileSetter> createState() => _ProfileSetterState();
}

class _ProfileSetterState extends State<ProfileSetter> {
  var firebaseServices = FirebaseServices();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    );;
  }
}