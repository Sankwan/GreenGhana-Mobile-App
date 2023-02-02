import 'package:flutter/material.dart';
import 'package:instagram_aa/models/posts_model.dart';
import 'package:instagram_aa/utils/custom_theme.dart';
import 'package:instagram_aa/views/widgets/requestwidgets/form_input_builder.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController editNameController;
  late TextEditingController editNumberController;

  @override
  void initState() {
    editNameController = TextEditingController();
    editNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    editNameController.dispose();
    editNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Edit your Profile'),
        centerTitle: true,
        elevation: .5,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, top: 25, right: 30),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        //how to make users profile image appear here by default and then change after edit is done
                        image:const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child:const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
            'Name',
            style: subtitlestlye.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          //current user name
              FormInputBuilder(hintText: '',
              controller: editNameController,),
              const SizedBox(
                height: 35,
              ),
                Text(
            'Number',
            style: subtitlestlye.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          //current user number
              FormInputBuilder(hintText: '',
              controller: editNumberController,
              keyboardType: TextInputType.number,             
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white),
                    child:const Text("CANCEL",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
