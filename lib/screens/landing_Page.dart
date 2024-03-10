import 'package:flutter/material.dart';
import 'package:closet_app/screens/screens.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/utils/constants.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    // Get the height of the device screen
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent, // Make background transparent
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black.withOpacity(0.5), // Adjusted opacity for smoother blend
              Colors.grey.withOpacity(0.2),
            ],
            stops: const [0.0, 0.55, 1.0], // Adjusted gradient stops
            begin: Alignment.topCenter, // Gradient starts from the top
            end: Alignment.bottomCenter, // Gradient ends at the bottom
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WEAR',
                    style: headline.copyWith(fontSize: 40.0),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    """    Revolutionize your wardrobe with Wear! 
     Digitize and discover endless outfit possibilities. 
      Your fashion journey starts here.""",
                    textAlign: TextAlign.center,
                    style: headline2.copyWith(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40.0,
              left: 0,
              right: 0,
              child: Center(
                child: Mainbutton(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const LoginPage())); // Navigate to LoginPage on button press
                  },
                  btnColor: blueButton,
                  text: 'Get Started',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
