import 'package:flutter/material.dart';
import 'package:instagram_aa/views/screens/planting_info.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({super.key});

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request History',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        elevation: .5,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        children: [
          Center(
            child: Container(
              height: 400,
              child: Card(
          elevation: 50,
          shadowColor: Colors.black,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Username:', style: CustomTextStyle.nameOfTextStyle),
                          Text('', style: CustomTextStyle.nameOfTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Phone Number:', style: CustomTextStyle.nameOfTextStyle,),
                          Text('', style: CustomTextStyle.nameOfTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Seedling Request:', style: CustomTextStyle.nameOfTextStyle,),
                          Text('', style: CustomTextStyle.nameOfTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Text('PickUp Location:', style: CustomTextStyle.nameOfTextStyle),
                          Text('', style: CustomTextStyle.nameOfTextStyle),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Text('Report to your pickup location to receive your seedlings on the 9th June 2023.\nWe will make an extension for two additional days\nOperation 10 Million Seedlings!', )
                      ],
                  ),
                ),
              
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextStyle {
  static const TextStyle nameOfTextStyle = TextStyle(
    fontSize: 20,
  );
}