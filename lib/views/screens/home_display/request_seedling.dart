// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/controllers/firebase_services.dart';
import 'package:instagram_aa/models/request_model.dart';
import 'package:instagram_aa/provider/request_provider.dart';
import 'package:instagram_aa/provider/userprovider.dart';
import 'package:instagram_aa/services/firebase_service.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/utils/tablist.dart';
import 'package:instagram_aa/views/widgets/custom_widgets.dart';
import 'package:instagram_aa/views/widgets/glitch.dart';
import 'package:provider/provider.dart';

import '../../../controllers/request_controller.dart';
import '../../../utils/custom_theme.dart';
import '../../../utils/custombutton.dart';
import '../../widgets/custominputfield.dart';
import '../../widgets/requestwidgets/appbar.dart';
import '../../widgets/requestwidgets/form_input_builder.dart';

class RequestSeedling extends StatefulWidget {
  const RequestSeedling({super.key});

  @override
  State<RequestSeedling> createState() => _RequestSeedlingState();
}

class _RequestSeedlingState extends State<RequestSeedling> {
  late TextEditingController seedCountController;
  final RequestControllerImplement controller = RequestControllerImplement();
  var cart = [];
  RequestModel user_request = RequestModel();

  // Checking if user has a request already
  check_request() async {
    var request = await firebaseFireStore
        .collection('seedlings-request')
        .where('user_id', isEqualTo: mAuth.currentUser!.uid)
        .get();
    if (request.docs.isNotEmpty) {
      user_request = RequestModel.fromJson(request.docs[0].data());
    }
  }

  @override
  void initState() {
    seedCountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    seedCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    check_request();
    RequestProvider rp = context.watch<RequestProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: RequestAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Text(
            'Select seedling type',
            style: subtitlestlye.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          CustomInputField(
            childwidget: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: seedlingList.map<DropdownMenuItem<String>>((nv) {
                  return DropdownMenuItem<String>(
                      value: nv,
                      child: Text(
                        nv,
                        style: subtitlestlye.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ));
                }).toList(),
                hint: Text(
                  rp.selectedSeed,
                  style: subtitlestlye.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary),
                ),
                onChanged: rp.onSeedSelect,
                icon: const Icon(Icons.unfold_more_outlined),
                isExpanded: true,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Enter number of Seedlings for ${rp.selectedSeed == "seed..." ? "" : rp.selectedSeed}',
            style: subtitlestlye.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FormInputBuilder(
            hintText: '...',
            keyboardType: TextInputType.phone,
            controller: seedCountController,
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: CustomButton(
              onpress: () {
                RequestProvider rp = context.read<RequestProvider>();
                String seedQuantity = seedCountController.text.trim();
                if (seedQuantity.isEmpty) {
                  return showSnackBar(context, 'Enter number of seedling');
                }
                if (rp.selectedSeed == "seed...") {
                  return showSnackBar(
                      context, 'please selecet a valid seedling');
                }
                // if (rp.selectedLocation == "location...") {
                //   return showSnackBar(context, 'please select pickup location');
                // }
                cart.add({
                  'seed_type': rp.selectedSeed,
                  'seed_quantity': seedQuantity,
                  // 'pickup_location': rp.selectedLocation
                });
                setState(() {
                  seedCountController.clear();
                });
                //check how rightly implemented this is
                if (seedQuantity == '...') {
                  cart.removeAt(0);
                }
                logger.d(cart);
              },
              label: 'Add',
            ),
          ),
          SizedBox(
            height: 35,
          ),
          cart.length > 0
              ? Text(
                  'Confirm your request',
                  textAlign: TextAlign.center,
                  style: subtitlestlye.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                )
              : Container(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cart.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cart[index]['seed_type']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(cart[index]['seed_quantity']),
                    SizedBox(
                      width: 7,
                    ),
                    IconButton(
                        onPressed: () {
                          cart.removeAt(index);
                          setState(() {});
                        },
                        icon: const Icon(
                          CupertinoIcons.clear_circled_solid,
                          color: Colors.red,
                        ))
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 35,
          ),
          cart.length > 0
              // Location Input
              ? Column(
                  children: [
                    Text(
                      'Select Location to receive the seedlings',
                      style: subtitlestlye.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomInputField(
                      childwidget: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: seedLocationList
                              .map<DropdownMenuItem<String>>((nv) {
                            return DropdownMenuItem<String>(
                                value: nv,
                                child: Text(
                                  nv,
                                  style: subtitlestlye.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ));
                          }).toList(),
                          hint: Text(
                            rp.selectedLocation,
                            style: subtitlestlye.copyWith(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          onChanged: rp.onLocationSelect,
                          icon: const Icon(Icons.unfold_more_outlined),
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          SizedBox(
            height: 35,
          ),
          cart.length > 0
              // Upload Seedling
              ? CustomButton(
                  onpress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          actionsAlignment: MainAxisAlignment.center,
                          title: Icon(
                            Icons.warning_rounded,
                            size: 60,
                            color: Colors.orangeAccent,
                          ),
                          content: Text(
                              'Once Request has been made, you cannot make another request.\n Do you wish to continue or add more seedlings to your request?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No')),
                            ElevatedButton(
                                onPressed: () {
                                  uploadSeedling();
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'))
                          ],
                        );
                      },
                    );
                  },
                  label: 'Submit')
              : Container(),
          cart.length < 1
              ? ElevatedButton(
                  onPressed: () {
                    user_request.userId == null
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text('No Requests Made'),
                            ),
                          )
                        : showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              title: Text('Request History'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Text('Username: ${}'),
                                  Text(
                                      'Phone Number: ${user_request.userPhoneNumber!}'),
                                  Column(
                                    children:
                                        user_request.seedRequest!.map((each) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('Request'),
                                            Text(
                                                'Seed Quantity: ${each['seed_quantity']}'),
                                            Text(
                                                'Seed Type: ${each['seed_type']}')
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Text(
                                    'Pickup Location: ${user_request.pickupLocation}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Close'))
                              ],
                            ),
                          );
                  },
                  child: Text('Check Request History'))
              : Container()
        ],
      ),
    );
  }

  Future uploadSeedling() async {
    RequestProvider rp = context.read<RequestProvider>();
    String seedQuantity = seedCountController.text.trim();
    var checkUser = await firebaseFireStore
        .collection('seedlings-request')
        .where('user_id', isEqualTo: mAuth.currentUser!.uid)
        .get();
    if (checkUser.docs.isNotEmpty) {
      return showSnackBar(context, "You cannot make more than one request");
    }
    // if (seedQuantity.isEmpty) {
    //   return showSnackBar(context, 'Enter number of seedling');
    // }
    // if (rp.selectedSeed == "seed...") {
    //   return showSnackBar(context, 'please selecet a valid seedling');
    // }
    if (rp.selectedLocation == "location..." ||
        rp.selectedLocation == 'location') {
      return showSnackBar(context, 'please select pickup location');
    }
    showProgressLoader();
    bool isRequested = await controller.addRequest(
      request: RequestModel(
          // seedType: rp.selectedSeed,
          // seedQuantity: seedQuantity,
          pickupLocation: rp.selectedLocation,
          seedRequest: cart,
          userPhoneNumber:
              context.read<UserProvider>().usermodel.userPhoneNumber),
    );
    if (isRequested) {
      cancelProgressLoader();
      showSnackBar(context, 'Request submitted successfully');
      seedCountController.clear();
      cart.clear();
      rp.clearFields();
    } else {
      cancelProgressLoader();
      showSnackBar(context, 'Error requesting seedling');
    }
  }
}
