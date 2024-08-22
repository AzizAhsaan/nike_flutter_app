import 'package:flutter/material.dart';

class ThirdOnboardPage extends StatelessWidget {
  const ThirdOnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/NikeLogo3.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                height: 270,
                width: 330,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              "You Have the Power To",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                textAlign: TextAlign.center,
                'There Are Many Beautiful And Attractive Plants To Your Room',
                style: TextStyle(color: Color(0xFFD8D8D8), fontSize: 14),
              ),
            ),
          ],
        )
      ],
    );
  }
}
