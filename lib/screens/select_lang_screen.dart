import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liveasy/global/colors.dart';

import 'phone_auth_screen.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/image.png",
              width: 56,
              height: 56,
            ),
            const SizedBox(
              height: 26,
            ),
            const Text(
              "Please select your Language",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "You can change the language\nat any time.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 48,
              child: DropdownMenu(
                width: 216,
                initialSelection: "English",
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: "English", label: "English"),
                  DropdownMenuEntry(value: "Hindi", label: "Hindi"),
                ],
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                fixedSize: const Size(216, 48),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const PhoneAuth();
                  },
                ));
              },
              child: Text(
                "NEXT",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Image.asset("assets/wave1.png")
          ],
        ),
      )),
    );
  }
}
