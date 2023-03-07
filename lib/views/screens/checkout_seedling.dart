import 'package:flutter/material.dart';
import 'package:instagram_aa/views/screens/request_status.dart';

class CheckoutSeedling extends StatefulWidget {
  final List<Map> cartItems;
  final String name;
  final String loc;
  final String number;
  const CheckoutSeedling(
      {Key? key,
      required this.cartItems,
      required this.name,
      required this.number,
      required this.loc})
      : super(key: key);

  @override
  State<CheckoutSeedling> createState() => _CheckoutSeedlingState();
}

class _CheckoutSeedlingState extends State<CheckoutSeedling> {
  @override
  Widget build(BuildContext context) {
    var cart = widget.cartItems.removeAt(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seedling Checkout',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          Text(
            widget.loc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            widget.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.cartItems[index]['name']),
                trailing: Text(widget.cartItems[index]['quantity']),
              );
            },
          )),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestStatus()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
