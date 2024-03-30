import 'package:flutter/material.dart';
import 'package:closet_app/screens/screens.dart';
import 'package:closet_app/widgets/widgets.dart';
import 'package:closet_app/utils/constants.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey,
              Colors.black.withOpacity(0.5),
              Colors.grey.withOpacity(0.2),
            ],
            stops: const [0.0, 0.55, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
              child: Text(
                'WEAR',
                style: headline.copyWith(fontSize: 40.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Your own digital closet',
                style: headline.copyWith(fontSize: 30.0),
              ),
            ),
            SizedBox(height: 15.0),
            Expanded(
              child: Center(
                child: Container(
                  width: width * 0.9, // 90% of the screen width
                  child: AspectRatio(
                    aspectRatio: 10 / 15, // Custom aspect ratio
                    child: Image.asset(
                      'assets/image/page2.jpg',
                      fit: BoxFit.fill, // Stretch the image to fit the container
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0), // Adjusted SizedBox height
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  Mainbutton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => const LoginPage()),
                      );
                    },
                    btnColor: Colors.black,
                    text: 'Get Started',
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const LoginPage()),
                      );
                    },
                    child: TextButton(
                      onPressed: () {},
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Have an account? ',
                            style: headline.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: ' Sign In',
                            style: headlineDot.copyWith(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
