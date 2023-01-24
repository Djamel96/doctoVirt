import 'package:doctovirt/elements/rounded_button.dart';
import 'package:flutter/material.dart';

import '../elements/custom_card.dart';
import '../elements/custom_inkwell.dart';

class ChooseProfileTypeScreen extends StatefulWidget {
  const ChooseProfileTypeScreen({super.key});

  @override
  State<ChooseProfileTypeScreen> createState() =>
      _ChooseProfileTypeScreenState();
}

class _ChooseProfileTypeScreenState extends State<ChooseProfileTypeScreen> {
  bool? isDoctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(),
          const Text(
            "Please choose an option",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          CustomCardW(
            child: Column(
              children: [
                CustomInKWell(
                  onTap: () {
                    setState(() {
                      isDoctor = false;
                    });
                  },
                  child: Row(
                    children: [
                      isDoctor == false
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.circle_outlined,
                            ),
                      const SizedBox(width: 12),
                      const Text(
                        "I'm a patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomCardW(
            child: Column(
              children: [
                CustomInKWell(
                  onTap: () {
                    setState(() {
                      isDoctor = true;
                    });
                  },
                  child: Row(
                    children: [
                      isDoctor == true
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.circle_outlined,
                            ),
                      const SizedBox(width: 12),
                      const Text(
                        "I'm a doctor",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          RoundedButton(content: "Next"),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
