import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/presentation/sign_in/signin_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 210,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Email", hintStyle: TextStyle()),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "password", hintStyle: TextStyle()),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Sign Up")),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(SignInPage());
                      },
                      child: Text("Login"))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
