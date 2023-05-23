import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liveasy/screens/select_user_type_screen.dart';

import '../global/colors.dart';
import '../widget/custom_otp_text_field.dart';

class VerifyOTP extends StatelessWidget {
  final String phoneNo;
  final String verificationId;
  VerifyOTP({required this.phoneNo, required this.verificationId, super.key});

  final TextEditingController otpController = TextEditingController();

  verifyOTP(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    var smsCode = otpController.text;

    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    auth.signInWithCredential(credential).then((UserCredential result) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const SelectUserTypeScreen()));
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Invalid code!!"),
        ),
      );
      log("$e");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height - MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Verify Phone",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Code is sent to $phoneNo",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomOTPTextField(
                        deviceWidth: MediaQuery.of(context).size.width,
                        textEditingController: otpController,
                        boxSize: 48,
                        inputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          gapPadding: 0,
                          borderSide: const BorderSide(
                            color: Color(0xff93D2F3),
                            width: 2,
                          ),
                        ),
                        cursorColor: primaryColor,
                        otpLength: 6,
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        spaceBetweenTextFields: 6,
                        cursorHeight: 30,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          fixedSize: const Size(double.infinity, 48),
                        ),
                        onPressed: () {
                          verifyOTP(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                          ),
                          child: Text(
                            "VERIFY AND CONTINUE",
                            style: GoogleFonts.montserrat().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Image.asset("assets/wave3.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
