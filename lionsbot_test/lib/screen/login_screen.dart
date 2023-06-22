import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());
  bool _showText = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.pinkAccent, Colors.blue, Colors.white]),
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Log In',
                    style: textTheme.titleLarge!
                        .copyWith(color: const Color(0xFFFAF8F9)),
                  )),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 60, bottom: 0),
                        child: TextField(
                          obscureText: false,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFAF8F9),
                              border: OutlineInputBorder(),
                              hintText: 'Email'),
                          controller: authController.usernameController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 40, bottom: 0),
                        child: StatefulBuilder(builder: (context, setS) {
                          return TextField(
                            obscureText: _showText,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFFAF8F9),
                                suffixIcon: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        !_showText ? Colors.grey : Colors.blue,
                                    padding: const EdgeInsets.all(16.0),
                                    textStyle: const TextStyle(fontSize: 15),
                                  ),
                                  onPressed: () => setS(() {
                                    _showText = !_showText;
                                  }),
                                  child: Text(!_showText ? "hide" : "show"),
                                ),
                                border: const OutlineInputBorder(),
                                hintText: 'Password'),
                            controller: authController.passwordController,
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 100, bottom: 0),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                            ),
                            onPressed: () {
                              authController.login();
                            },
                            child: Text("Log In",
                                textAlign: TextAlign.center,
                                style: textTheme.titleLarge!
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              child: const Text(
                                'Forgot your password?',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
