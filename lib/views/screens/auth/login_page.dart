import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/auth_controller.dart';
import 'package:instagram_aa/controllers/form_fields_controller.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/app_utils.dart';
import 'package:instagram_aa/views/widgets/glitch.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                "Welcome Back To \nGreen Ghana",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              )),
              SizedBox(height: 20,),
              Text('Enter your number to \nreturn to your account', textAlign: TextAlign.center,),
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
                    FirebaseAuthLoginMethod()
                        .phoneSignIn(context, "+233$normalNumber");
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
