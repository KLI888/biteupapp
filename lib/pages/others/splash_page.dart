import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import the page to navigate to after splash

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Delay for 1 second before navigating to the next page
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SignupPage()), // Navigate to SignupPage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEC008C), // Top color (#EC008C)
              Color(0xFFFC6767), // Bottom color (#FC6767)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Biteup.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 66,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Text(
              "Homely Flavors, Just a Click Away!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
