import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instagram_aa/controllers/auth_controller.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/controllers/form_fields_controller.dart';
import 'package:instagram_aa/utils/app_utils.dart';
import 'package:instagram_aa/utils/pagesnavigator.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/views/screens/auth/signup_page.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../animation/slideanimate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _numberController = TextEditingController();

  List users = [];
  Future userList(String number) async {
    var value = await firebaseFireStore
        .collection('users')
        .where('user_phoneNumber', isEqualTo: number)
        .get();
    return value.docs.isNotEmpty;
  }

  final _formKey = GlobalKey<FormState>();

  handlePermissions() async {
    var status = await Permission.location
        .request()
        .then((value) => Permission.locationAlways.request());
    if (status.isDenied) {
      status = await Permission.locationAlways.request();
    } else if (status.isGranted) {
      status = await Permission.locationAlways.request();
      return;
    } else if (status.isPermanentlyDenied) {
      status = await Permission.locationAlways.request();
      return;
    }
  }

  @override
  void initState() {
    handlePermissions();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handlePermissions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    // logger.d(users);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.asset('assets/images/greenghanalogo.png'),
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                "Welcome To \nGreen Ghana",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter your number to \nreturn to your account',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.1,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formKey, child: numberFormField(_numberController)),
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.07,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String normalNumber =
                        AppUtils.normalizePhoneNumber(_numberController.text);
                    // logger.d("+233$normalNumber");
                    // logger.d(await userList('+233$normalNumber'));
                    if (await userList('+233$normalNumber')) {
                      FirebaseAuthLoginMethod()
                          .phoneLogIn(context, "+233$normalNumber");
                    } else {
                      showSnackBar(context, 'Please register to use App');
                    }
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: const Text("Login"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have Account?'),
                  TextButton(
                      onPressed: () {
                        nextScreen(context, SlideAnimate(const SignupPage()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.green),
                      )),
                ],
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.09,
              ),
              Text('Ministry of Lands and Natural Resources'),
              SizedBox(
                height: 5,
              ),
              Text('Ghana Forestry Commission'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/ministrieslogo.jpeg'),
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    child: Image.asset('assets/images/fclogo.png'),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/ghanaflag2.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
