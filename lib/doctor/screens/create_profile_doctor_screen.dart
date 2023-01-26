import 'package:doctovirt/doctor/screens/account_under_review_screen.dart';
import 'package:doctovirt/elements/custom_card.dart';
import 'package:doctovirt/elements/rich_text_field.dart';
import 'package:doctovirt/elements/rounded_button.dart';
import 'package:doctovirt/helper/constants.dart';
import 'package:doctovirt/helper/keyboard_dismiss.dart';
import 'package:doctovirt/them/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProfileDoctorScreen extends StatefulWidget {
  const CreateProfileDoctorScreen({super.key});

  @override
  State<CreateProfileDoctorScreen> createState() =>
      _CreateProfileDoctorScreenState();
}

class _CreateProfileDoctorScreenState extends State<CreateProfileDoctorScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final specialtyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(title: const Text("Create profile")),
      body: CustomCardW(
        // paddings: EdgeInsets.all(12),
        margins: const EdgeInsets.all(12),
        child: ListView(
          // padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Please enter the below information to create your profile",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  RichTextField(
                    label: "Full name",
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    validator: (val) {
                      if (val?.isEmpty ?? true) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  RichTextField(
                    controller: emailController,
                    label: "Email",
                    validator: (value) {
                      if (!EmailValidator.validate(value!.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  RichTextField(
                    label: "Phone number",
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                  ),
                  const SizedBox(height: 12),
                  RichTextField(
                    label: "Specialty",
                    controller: specialtyController,
                    validator: (val) {
                      if (val?.isEmpty ?? true) {
                        return "Please enter the specialty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  RoundedButton(
                    content: "Submit",
                    onPressed: () => _submitProfile(),
                    loading: loading,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _submitProfile() {
    keyBoardDispose(context);
    final form = _formKey.currentState;
    if (!loading && form!.validate()) {
      setState(() {
        loading = true;
      });
      Get.off(() => const AccountUnderReviewScreen());
    }
  }
}
