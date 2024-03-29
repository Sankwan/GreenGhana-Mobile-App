import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_aa/views/screens/home_display/bottom_nav_bar.dart';
import 'package:instagram_aa/views/screens/planting_info.dart';

//working
class RequestStatus extends StatelessWidget {
  const RequestStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/tick.png'))),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Request Successful !',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Report to your chosen location to receive seedlings from our Officers',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 250,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar()),
                      (route) => false,
                    );
                  },
                  icon: Icon(Icons.dashboard_rounded),
                  label: Text('Return Home')),
              FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlantingInfo()));
                  },
                  icon: Icon(FontAwesomeIcons.tree),
                  label: Text('Planting'))
            ],
          ),
        ],
      ),
    );
  }
}
