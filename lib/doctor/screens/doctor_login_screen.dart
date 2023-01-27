import 'package:doctovirt/doctor/services/login_service.dart';
import 'package:doctovirt/elements/custom_card.dart';
import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:doctovirt/elements/rich_text_field.dart';
import 'package:doctovirt/elements/rounded_button.dart';
import 'package:doctovirt/them/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../helper/keyboard_dismiss.dart';
import 'create_profile_doctor_screen.dart';
import 'patient_request_screen.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({super.key});

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool keyboardIsVisible = false;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (mounted) {
        setState(() {
          keyboardIsVisible = visible;
        });
      }
    });
    Future.delayed(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: CustomCardW(
          child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: keyboardIsVisible ? 120 : 300,
                child: Image.asset(
                  "assets/doctoVirt.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          SizedBox(height: keyboardIsVisible ? 12 : 30),
          Form(
              key: _formKey,
              child: Column(
                children: [
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
                    label: "Password",
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please enter the password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  RoundedButton(
                    content: "Login",
                    onPressed: () => _login(),
                    loading: loading,
                  ),
                  const SizedBox(height: 30),
                  CustomInKWell(
                    onTap: () =>
                        Get.to(() => const CreateProfileDoctorScreen()),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Create an account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      )),
    );
  }

  _login() {
    keyBoardDispose(context);
    final form = _formKey.currentState;
    if (!loading && form!.validate()) {
      setState(() {
        loading = true;
      });
      login(email: emailController.text, password: passwordController.text)
          .then((value) {
        Get.to(() => const PatientRequestScreen());
      });
    }
  }
}
