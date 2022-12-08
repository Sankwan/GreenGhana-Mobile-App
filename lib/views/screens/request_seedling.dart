import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/views/screens/checkout_seedling.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
//working
class RequestSeedling extends StatefulWidget {
  const RequestSeedling({super.key});

  @override
  State<RequestSeedling> createState() => _RequestSeedlingState();
}

class _RequestSeedlingState extends State<RequestSeedling> {
  User? user;
  bool teak = false;
  bool pear = false;
  bool coconut = false;
  bool largent = false;
  int teakCount = 0;
  int pearCount = 0;
  int coconutCount = 0;
  int largentCount = 0;

  List seedling = ['Teak', 'Pear', 'Cocunut', 'Largent'];
  List<bool> seedSeleted = [false, false, false, false];
  List<int> seedCount = [1, 1, 1, 1];

  List<Map> addCart = [];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text(
          'Make a Seedling Request',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ListView(children: [
          const SizedBox(
            height: 50,
          ),
          const Text('Seedlings we have'),

          // Availabe Seedlings
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: seedling.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: seedSeleted[index],
                    onChanged: (value) {
                      setState(() {
                        seedSeleted[index] = value!;
                      });
                    },
                  ),
                  title: Text(seedling[index]),
                  trailing: seedSeleted[index]
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: seedCount[index] > 1
                                  ? () {
                                      setState(() {
                                        seedCount[index] -= 1;
                                      });
                                    }
                                  : null,
                              child: const Text('-'),
                              style: styleButton(),
                            ),
                            Text(seedCount[index].toString()),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  seedCount[index] += 1;
                                });
                              },
                              child: const Text('+'),
                              style: styleButton(),
                            )
                          ],
                        )
                      : null,
                );
              },
            ),
          ),
          const SizedBox(height: 50),
          DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  // labelText: 'type location here',
                  hintText: 'select or type location here',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            items: const [
              "Forestry HQ",
              "Accra Mall",
              "WestHills Mall",
              'Tema Central Mall',
              'Central University'
            ],
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Location to receive seedlings",
                labelStyle: TextStyle(fontSize: 18),
              ),
            ),
            onChanged: print,
            selectedItem: "Forestry HQ",
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: TextButton(
              onPressed: (() async {
                // var idx;
                addCart.clear();

                for (var i = 0; i < seedSeleted.length; i++) {
                  if (seedSeleted[i] && addCart.isEmpty) {
                    addCart.add({
                      'name': seedling[i],
                      'quantity': seedCount[i].toString()
                    });
                  } else if (seedSeleted[i] && addCart.isNotEmpty) {
                    for (var idx = 0; idx < addCart.length; idx++) {
                      if (addCart[idx]['name'] == seedling[i]) {
                        addCart[idx] = {
                          'name': seedling[i],
                          'quantity': seedCount[i].toString()
                        };
                      }
                    }
                  }
                  if (seedSeleted[i] &&
                      !addCart.contains({
                        'name': seedling[i],
                        'quantity': seedCount[i].toString()
                      })) {
                    addCart.add({
                      'name': seedling[i],
                      'quantity': seedCount[i].toString()
                    });
                  }
                  if (seedSeleted[i] &&
                      addCart.contains({
                        'name': seedling[i],
                        'quantity': seedCount[i].toString()
                      })) {
                    addCart.remove({
                      'name': seedling[i],
                      'quantity': seedCount[i].toString()
                    });
                  }
                }
                if (seedSeleted.contains(true)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => CheckoutSeedling(
                            name: 'Current User',
                            loc: 'Place',
                            number: 'User number',
                            cartItems: addCart,
                          )),
                    ),
                  );
                }
              }),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  'Proceed',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),

          //beginning of test dropdowns
          //to implement this in the edit

DropdownSearch<String>.multiSelection(
    items: ["Teak", "Coco", "Guava", 'C', 'k','q','r', 's', 'braee','tectona'],
    popupProps: PopupPropsMultiSelection.menu(
        showSelectedItems: true,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  // labelText: 'type location here',
                  hintText: 'select or type specie(s) here',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
    ),
    onChanged: print,
    selectedItems: ["Teak"],
),
        ]),
      ),
    
    );
  }
}