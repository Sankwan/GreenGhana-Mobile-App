import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/auth_controller.dart';
import 'package:instagram_aa/controllers/form_fields_controller.dart';
import 'package:instagram_aa/utils/app_utils.dart';

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
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 0),
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
              SizedBox(height: _mediaQuery.size.height * 0.01),
              const Text(
                "Welcome To \nGreen Ghana",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              SizedBox(height: _mediaQuery.size.height * 0.01),
              Text('Don\'t have an account? \nEnter your number to Register', textAlign: TextAlign.center,),
              SizedBox(
                height: _mediaQuery.size.height * 0.07
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formKey, child: numberFormField(_numberController)),
              ),
               SizedBox(
                height: _mediaQuery.size.height * 0.07
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
          SizedBox(
            height: _mediaQuery.size.height * 0.15
          ),
          Text('Ministry of Lands and Natural Resources'),
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
