import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class YearGraph extends StatefulWidget {
  const YearGraph({super.key});

  @override
  State<YearGraph> createState() => _YearGraphState();
}

class _YearGraphState extends State<YearGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Year to Year'),
        centerTitle: true,
      ),
      body: ListView(
        children: [         
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 40),
            child: Text(
                    '2022',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
          ),
          Divider(
            thickness: 0.2,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Target Seedlings',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '10,000,000',
                      // jsonList.isEmpty ? 'No Data' : jsonList.toString()
                      style: TextStyle(color: Colors.brown, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Distributed Seedlings',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '26647495',
                      style: TextStyle(color: acceptedColor, fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 5),
            child: Text('Remarks: Target Exceeded', style: TextStyle(fontSize: 15),),
          ),
          //2021
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 80),
            child: Text(
                    '2021',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
          ),
          Divider(
            thickness: 0.2,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Target Seedlings',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '5,000,000',
                      // jsonList.isEmpty ? 'No Data' : jsonList.toString()
                      style: TextStyle(color: Colors.brown, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Distributed Seedlings',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '7,000,000',
                      style: TextStyle(color: acceptedColor, fontSize: 20),
                    )
                  ],
                ),
              ),
        ],
      ),
      Padding(
            padding: const EdgeInsets.only(left: 45, top: 5),
            child: Text('Remarks: Target Exceeded', style: TextStyle(fontSize: 15),),
          ),
    ]));
  }
}