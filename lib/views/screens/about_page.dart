
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Green Ghana'),
        centerTitle: true,
        actions: [
           TextButton(
              onPressed: () async {
                final url = 'https://www.green-ghana.fcghana.org/#features';

                openBrowserURL(
                  url: url,
                  inApp: false,
                );
              },
              child: const Text(
                'Privacy Policy',
                style:
                    TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
              )),
        ],
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            height: 250,
            width: 250,
            child: Image.asset('assets/images/greenghanalogo.png'),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 20, top: 20),
            child: Text(
              ' Ghana has been losing rainforest at an alarming rate in recent years, but the government of Ghana is taking steps to change all that. The initiative forms part of the efforts by the Ministry of Lands and Natural Resources (MLNR) and the Forestry Commission to encourage Ghanaians to plant more trees to preserve and protect the country\'s forest cover and the environment in general. \n\n This app is to make good enough public awareness on the lengths to which the Green Ghana Day is going.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextButton(
              onPressed: () async {
                final url = 'https://greenghana.mlnr.gov.gh';

                openBrowserURL(
                  url: url,
                  inApp: true,
                );
              },
              child: const Text(
                'Tap for more information on the Green Ghana Project',
                style:
                    TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            'Need Help with Something?',
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              openwhatsapp();
            },
            child: Text(
              'Contact Us on Whatsapp',
              style: TextStyle(color: Colors.green),
            ),
          ),
                    TextButton(
            onPressed: () {
          launchEmail();
            },
            child: Text(
          'Email Us',
          style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
  //to open whatsapp 
  openwhatsapp() async{
  var whatsapp ="+233557889480";
  var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
  var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
  if(Platform.isIOS){
    // for iOS phone only
    if( await canLaunch(whatappURL_ios)){
       await launch(whatappURL_ios, forceSafariVC: false);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }

  }else{
    // android , web
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }
  }
}
}

//fix deprecation later 

//to open browser in app
Future openBrowserURL({
  required String url,
  bool inApp = false,
}) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: inApp,
      forceWebView: inApp,
      enableJavaScript: true,
    );
  }
}

//to open email
launchEmail() async {
    final url =
    Uri.encodeFull('mailto:fcgreenghana@gmail.com?subject=Green Ghana App&body=I need help with...');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
