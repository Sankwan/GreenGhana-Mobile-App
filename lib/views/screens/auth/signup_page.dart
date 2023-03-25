import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/auth_controller.dart';
import 'package:instagram_aa/controllers/form_fields_controller.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/app_utils.dart';
import 'package:instagram_aa/views/screens/auth/login_page.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/glitch.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _numberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              GlithEffect(
                  child: const Text(
                "Welcome To \nGreen Ghana",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              )),
              SizedBox(height: 20,),
              Text('Dont have an account? \nEnter your number to Register', textAlign: TextAlign.center,),
              const SizedBox(
                height: 70,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formKey, child: numberFormField(_numberController)),
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String normalNumber =
                        AppUtils.normalizePhoneNumber(_numberController.text);
                    FirebaseAuthMethod()
                        .phoneSignIn(context, "+233$normalNumber");
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: const Text("Register"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already with Us?'),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: (){
                    nextNav(context, LoginPage());
                  }, child: Text('Login')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
