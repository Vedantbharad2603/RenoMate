import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renomateworker/controllers/edit_user_profile_page_controller.dart';
import 'package:renomateworker/theme.dart';

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
              // buildMyTextField("User Name", controller.userNameController,
              //     width, "String", 255),
              buildMyTextField("First Name", controller.fnameController, width,
                  "String", 20),
              buildMyTextField(
                  "Last Name", controller.lnameController, width, "String", 20),
              buildMyTextField("Mobile Number",
                  controller.mobileNumberController, width, "Number", 13),
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.03, right: width * 0.03, top: 20),
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
                          padding: EdgeInsets.only(
                              left: width * 0.02, top: width * 0.02),
                          child: Text(
                            "Select your job profile",
                            style: TextStyle(
                              color: MyTheme.text,
                              fontSize: width * 0.045,
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButton<String>(
                            value: controller.selectedJobProfile.value,
                            isExpanded: true,
                            items:
                                controller.jobProfileItems.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: MyTheme.text,
                                    fontSize: width * 0.05,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller.selectedJobProfile.value = newValue!;
                            },
                            style: TextStyle(
                              color: MyTheme.text,
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w400,
                            ),
                            underline: Container(
                              height: 2,
                              color: MyTheme.accent,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: () {
                    controller.saveData(context);
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
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                readOnly: label == "Mobile Number",
                keyboardType: keyboardType,
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
