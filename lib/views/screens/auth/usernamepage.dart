import 'package:flutter/material.dart';
import 'package:instagram_aa/animation/slideanimate.dart';
import 'package:instagram_aa/controllers/user_controller.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/utils/custombutton.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/screens/home/mainhomepage.dart';

class UserNamePage extends StatefulWidget {
  final String phoneNumber;
  const UserNamePage({super.key, required this.phoneNumber});

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  late TextEditingController userNameController;
  final userControl = UserControllerImplement();

  @override
  void initState() {
    userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .5,
        title: const Text('Personal Information'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(
                  hintText: 'Enter Username',
                  hintStyle: TextStyle(color: Colors.black54)),
            ),
            const SizedBox(height: 16),
            CustomButton(onpress: () => saveUserData(), label: 'Save')
          ],
        ),
      ),
    );
  }

  Future saveUserData() async{
    if(userNameController.text.isEmpty){
      showSnackBar(context, 'username is required');
      return;
    }
    showProgressLoader();
    await userControl.addUser(usermodel: UserModel(
      userPhoneNumber: widget.phoneNumber,
      userName: userNameController.text.trim(),
      avatar: "",
      totalPosts: 0,
      totalLikes: 0,
      totalRequests: 0
    )).then((value) {
      cancelProgressLoader();
      nextscreenRemovePredicate(context, SlideAnimate(const MainHomepage()));
    }).onError((error, stackTrace) {
      showSnackBar(context, error.toString());
      cancelProgressLoader();
    });



  }
}
