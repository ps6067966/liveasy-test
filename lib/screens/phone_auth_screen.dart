import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field_with_validator/intl_phone_field.dart';
import 'package:liveasy/screens/select_user_type_screen.dart';
import 'package:liveasy/screens/verify_otp_screen.dart';

import '../global/colors.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String phoneNumner = "";

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          auth
              .signInWithCredential(authCredential)
              .then((UserCredential result) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectUserTypeScreen(),
              ),
            );
          }).catchError(
            (e) {},
          );
        },
        verificationFailed: (FirebaseAuthException authException) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOTP(
                        phoneNo: phoneNumner,
                        verificationId: verificationId,
                      )));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
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
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Please enter your mobile number",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "You’ll receive a 6 digit code\nto verify next.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        disableLengthCheck: true,
                        showDropdownIcon: false,
                        flagsButtonPadding: const EdgeInsets.only(
                          left: 12,
                        ),
                        autovalidateMode: AutovalidateMode.disabled,
                        invalidNumberMessage: "Please enter a valid number",
                        onChanged: (phone) {
                          phoneNumner = phone.completeNumber;
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          fixedSize: const Size(216, 48),
                        ),
                        onPressed: () {
                          if (phoneNumner.isNotEmpty &&
                              phoneNumner.length == 13) {
                            registerUser(phoneNumner, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter a valid number"),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "CONTINUE",
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Image.asset("assets/wave2.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
