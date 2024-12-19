import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/green_card_top.png'),
                Image.asset('assets/images/red_card_top.png'),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/ags_logo.png',
                    height: 150,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Smart Future Begins Here!',
                    style: TextStyle(color: Color(0xffD30000), fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 130),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Click Here to',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LogInScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xff01398D),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Attention Parents:',
                      style: TextStyle(
                        color: Color(0xff01398D),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: " Please contact your child’s school for Parent Portal login information.",
                          style: TextStyle(
                            color: Color(0xff01398D),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
