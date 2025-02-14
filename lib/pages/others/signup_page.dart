import 'package:biteupcontent/pages/others/otp_page.dart';
import 'package:biteupcontent/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            begin: Alignment.topCenter, // Gradient starts from the top
            end: Alignment.bottomCenter, // Gradient ends at the bottom
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Biteup.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      )),
                  Container(
                    width: 150,
                    child: Text(
                      "Homely Flavors, Just a Click Away!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.070,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    // decoration: BoxDecoration(color: Colors.white),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: CustomTextField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        hintText: "Enter your number",
                        prefixText: "+91",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.050,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerificationPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xFF640041),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // Expanded(child: Text("")),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "By Continuing, you agree to our",
                          style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Terms of Use",
                              style: TextStyle(color: Color(0xFF640041)),
                            ),
                            Text(
                              " & ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Privacy Policy",
                              style: TextStyle(color: Color(0xFF640041)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
//
// class FirstContainerClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {}
//
//   @override
//   bool showReclip(CustomClipper<Path> oldClipper) => false;
// }
