import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/buttons/custom_buttons_login.dart';
import '../components/textfields/text_fields.dart';
import '../services/auth_apis.dart';
import '../utlis/utlis.dart';
import 'home_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final emailError = Utlis.validateEmail(_emailController.text.trim());
      final passwordError = Utlis.passValidator(_passwordController.text.trim());

      if (emailError != null || passwordError != null) {
        if (emailError != null) {
          Utlis().showError(context, emailError);
        }
        if (passwordError != null) {
          Utlis().showError(context, passwordError);
        }
      } else {
        try {
          // Make API call
          await AuthAPI.studentLogIn(
            email: _emailController.text,
            password: _passwordController.text,
          );

          Utlis().showSuccess(context, 'Log In Successfully', shouldDismiss: true);

          // Navigate to the Home Screen on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } catch (e) {
          Utlis().showError(context, e.toString());
        } finally {
          setState(() {
            _isLoading = false; // Hide loading indicator
          });
        }
      }
    }
  }

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
                const Positioned(
                  top: 120,
                  left: 80,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'Email',
                          isPassword: false,
                          hintText: 'xyz@gmail.com',
                          validator: Utlis.validateEmail,
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          label: 'Password',
                          isPassword: true,
                          hintText: '1234567',
                          validator: Utlis.passValidator,
                          controller: _passwordController,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        CustomLoginButton(
                          text: _isLoading ? 'Logging in...' : 'Log In',
                          onPressed: _isLoading ? () {} : _login, // Disable button during loading
                        ),
                        const SizedBox(height: 152),
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
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
