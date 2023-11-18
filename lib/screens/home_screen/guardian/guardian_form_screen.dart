import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tutor_kit/const/consts.dart';
import 'package:tutor_kit/screens/home_screen/guardian/guardian_home.dart';
import 'package:tutor_kit/widgets/custom_button.dart';
import 'package:tutor_kit/widgets/custom_textfield.dart';

class GuardianFormScreen extends StatelessWidget {
  GuardianFormScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    TextEditingController mobileController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icTutor,
                    width: 100,
                    color: inversePrimary,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    preffixIcon: CircleAvatar(child: SvgPicture.asset(icName,),backgroundColor: Colors.transparent,),
                    type: TextInputType.text,
                    controller: nameController,
                    hint: "Enter your full name",
                    label: "Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name!';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.name],
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    preffixIcon: CircleAvatar(child: SvgPicture.asset(icPhone,),backgroundColor: Colors.transparent,),

                    type: TextInputType.number,
                    controller: mobileController,
                    hint: "Enter your phone number",
                    label: "Mobile No.",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.telephoneNumberNational],
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    preffixIcon: CircleAvatar(child: SvgPicture.asset(icLocation,),backgroundColor: Colors.transparent,),

                    type: TextInputType.text,
                    controller: addressController,
                    hint: "Enter your full address",
                    label: "Full Address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full address';
                      }
                      return null;
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.postalAddressExtendedPostalCode],
                  ),
                  SizedBox(height: 15,),
                  CustomButton(onPress: (){
                    if (_formKey.currentState!.validate()) {
                      var _auth = FirebaseAuth.instance;
                      FirebaseFirestore.instance
                          .collection("userInfo")
                          .doc(_auth.currentUser!.uid)
                          .update({
                        "mobile": mobileController.text.trim(),
                        "timestamp": FieldValue.serverTimestamp(),
                        "address": addressController.text.trim(),
                        "name": nameController.text.trim(),
                      });
                      Get.off(() => GuardianHome(currentNavIndex: 0.obs,));
                      box.write("user", "gd");
                    }
                  }, text: "Submit", color: Colors.grey.shade600)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
