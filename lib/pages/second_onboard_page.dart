import 'package:flutter/material.dart';

class SecondOnboardPage extends StatelessWidget {
  const SecondOnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/NikeLogo2.png',
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
              "Lets Start Jounrey With Nike",
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
                'Smart, Gorgeous & Fashionable Collection Explor Now',
                style: TextStyle(color: Color(0xFFD8D8D8), fontSize: 14),
              ),
            ),
          ],
        )
      ],
    );
  }
}
