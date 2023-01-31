// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_aa/models/request_model.dart';
import 'package:instagram_aa/models/usermodel.dart';
import 'package:instagram_aa/provider/request_provider.dart';
import 'package:instagram_aa/provider/userprovider.dart';
import 'package:instagram_aa/utils/progressloader.dart';
import 'package:instagram_aa/utils/showsnackbar.dart';
import 'package:instagram_aa/utils/tablist.dart';
import 'package:provider/provider.dart';

import '../../controllers/request_controller.dart';
import '../../utils/custom_theme.dart';
import '../../utils/custombutton.dart';
import '../widgets/custominputfield.dart';
import '../widgets/requestwidgets/form_input_builder.dart';

class RequestSeedling extends StatefulWidget {
  const RequestSeedling({super.key});

  @override
  State<RequestSeedling> createState() => _RequestSeedlingState();
}

class _RequestSeedlingState extends State<RequestSeedling> {
  late TextEditingController seedCountController;
  final RequestControllerImplement controller = RequestControllerImplement();

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
    RequestProvider rp = context.watch<RequestProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Make a Seedling Request',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        elevation: .5,
      ),
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
                items: seedLocationList.map<DropdownMenuItem<String>>((nv) {
                  return DropdownMenuItem<String>(
                      value: nv,
                      child: Text(
                        nv,
                        style: subtitlestlye.copyWith(
                            color: Theme.of(context).colorScheme.primary),
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
          const SizedBox(
            height: 24,
          ),
          CustomButton(
            onpress: () => uploadSeedling(),
            label: 'Send',
          ),
        ],
      ),
    );
  }

  Future uploadSeedling() async {
    RequestProvider rp = context.read<RequestProvider>();
    String seedQuantity = seedCountController.text.trim();
    if (seedQuantity.isEmpty) {
      return showSnackBar(context, 'Enter number of seedling');
    }
    if(rp.selectedSeed == "seed..."){
      return showSnackBar(context, 'please selecet a valid seedling');
    }
    if(rp.selectedLocation == "location..."){
      return showSnackBar(context, 'please select pickup location');
    }
    showProgressLoader();
    bool isRequested = await controller.addRequest(
      request: RequestModel(
          seedType: rp.selectedSeed,
          seedQuantity: seedQuantity,
          pickupLocation: rp.selectedLocation,
          userPhoneNumber:
              context.read<UserProvider>().usermodel?.userPhoneNumber),
    );
    if (isRequested) {
      cancelProgressLoader();
      showSnackBar(context, 'Request submitted successfully');
      seedCountController.clear();
      rp.clearFields();
    } else {
      cancelProgressLoader();
      showSnackBar(context, 'Error requesting seedling');
    }
  }
}
