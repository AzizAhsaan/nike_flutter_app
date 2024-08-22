import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import the google_fonts package

class FirstOnboardPage extends StatelessWidget {
  const FirstOnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/vector2.png',
            fit: BoxFit
                .cover, // Adjust how the image fits within the available space
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Highlight05.png',
                        height: 20,
                        width: 20,
                      ),
                      Text('Welcome to\nNike',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: GoogleFonts.raleway()
                                .fontFamily, // Use the appropriate font family from google_fonts package
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/images/Vector1.png'),
                ],
              ),
              // Removed the vector2 image from here
              Image.asset(
                'assets/images/onboardlegphoto.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                height: 325,
                width: 500,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
