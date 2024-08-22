import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/pages/first_onboard_page.dart';
import 'package:nike_app/pages/second_onboard_page.dart';
import 'package:nike_app/pages/third_onboard_page.dart';
import 'package:nike_app/widgets/on_board_container.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardContainer(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              FirstOnboardPage(),
              SecondOnboardPage(),
              ThirdOnboardPage(),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 40 : 20,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.white
                        : Color(0xFFFFB21A),
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage == 2) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(double.infinity, 50)), // Adjust the height as needed
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text(
                  _currentPage == 0 ? 'Get Started' : "Next",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

// class FirstOnboardPage extends StatelessWidget {
//   final VoidCallback onNext;

//   const FirstOnboardPage({required this.onNext, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset(
//                 'assets/images/Highlight05.png',
//                 height: 30,
//                 width: 30,
//               ),
//               Text(
//                 'Welcome to\nNike',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: GoogleFonts.raleway().fontFamily,
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.asset('assets/images/Vector1.png'),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: onNext,
//             child: Text('Next'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SecondOnboardPage extends StatelessWidget {
//   final VoidCallback onNext;

//   const SecondOnboardPage({required this.onNext, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Second Onboarding Page',
//             style: TextStyle(
//               fontFamily: GoogleFonts.raleway().fontFamily,
//               color: Colors.white,
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: onNext,
//             child: Text('Next'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ThirdOnboardPage extends StatelessWidget {
//   final VoidCallback onNext;

//   const ThirdOnboardPage({required this.onNext, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Third Onboarding Page',
//             style: TextStyle(
//               fontFamily: GoogleFonts.raleway().fontFamily,
//               color: Colors.white,
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: onNext,
//             child: Text('Go to Home'),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
