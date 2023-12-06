import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateclient/controllers/edit_user_profile_page_controller.dart';
import 'package:renomateclient/models/user_profile_model.dart';
import 'package:renomateclient/theme.dart';

class EditUserProfilePage extends StatelessWidget {
  EditUserProfilePage({super.key});

  final EditUserProfilePageController controller =
      Get.put(EditUserProfilePageController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyTheme.background,
      appBar: AppBar(
        title: const Text(
          "R E N O M A T E",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: MyTheme.accent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.05, top: 13),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Edit Profile",
                    style:
                        TextStyle(color: MyTheme.text, fontSize: width * 0.06),
                  ),
                ),
              ),
              buildMyTextField("First Name", controller.fnameController, width,
                  "String", 20),
              buildMyTextField(
                  "Last Name", controller.lnameController, width, "String", 20),
              buildMyTextField("Mobile Number", controller.mobileNumberController,
                  width, "Number", 13),
              const SizedBox(
                height: 15,
              ),
              horizontalLine(),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Address",
                    style:
                        TextStyle(color: MyTheme.text, fontSize: width * 0.045),
                  ),
                ),
              ),
              buildMyTextField("Block No.(or name)", controller.blockController,
                  width, "String", 255),
              buildMyTextField("Street Name", controller.streetController,
                  width, "String", 255),
              buildMyTextField(
                  "City", controller.cityController, width, "String", 255),
              buildMyTextField(
                  "State", controller.stateController, width, "String", 255),
              buildMyTextField(
                  "Pin Code", controller.pinCodeController, width, "Number", 7),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: () {
                    if (controller.areAllFieldsFilled()) {
                      // UserProfileModel userProfile = UserProfileModel(
                      //   userName: controller.userNameController.text,
                      //   mobileNumber: controller.mobileNumberController.text,
                      // );

                      controller.saveData(context);

                      // AddressModel address = AddressModel(
                      //   block: controller.blockController.text,
                      //   street: controller.streetController.text,
                      //   city: controller.cityController.text,
                      //   state: controller.stateController.text,
                      //   pinCode: controller.pinCodeController.text,
                      // );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Incomplete Information'),
                            content: const Text(
                                'Please fill in all the required information.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    height: width * 0.1,
                    width: width * 0.3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyTheme.button1,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: MyTheme.background,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.06,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMyTextField(String label, TextEditingController controller,
      double width, String inputType, int maxLen) {
    TextInputType keyboardType;
    if (inputType == "Number") {
      keyboardType = TextInputType.number;
    } else {
      keyboardType = TextInputType.text;
    }

    return Padding(
      padding:
          EdgeInsets.only(left: width * 0.03, right: width * 0.03, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: MyTheme.accent,
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.02, top: width * 0.02),
                child: Text(
                  label,
                  style: TextStyle(
                    color: MyTheme.text,
                    fontSize: width * 0.045,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                readOnly: label == "Mobile Number",
                controller: controller,
                keyboardType: keyboardType,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                maxLength: maxLen,
                style: TextStyle(
                  color: MyTheme.text,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyTheme.button2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                  contentPadding: EdgeInsets.all(width * 0.03),
                  counterStyle: TextStyle(
                    color: MyTheme.text,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget horizontalLine() {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MyTheme.accent,
        ),
      ),
    );
  }
}
