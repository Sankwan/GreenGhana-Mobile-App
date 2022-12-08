import 'package:flutter/material.dart';
import 'package:instagram_aa/views/widgets/text_input.dart';


class VerificationPage extends StatefulWidget {
  final String number;
  const VerificationPage({Key? key, required this.number}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              // AuthController.instance.pickImage();
            },
            child: Stack(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg"),
                  radius: 60,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _nameController,
              myLabelText: "Phone Number",
              myIcon: Icons.phone,
            ),
          ),
        ],
      ),
    );
  }
}
