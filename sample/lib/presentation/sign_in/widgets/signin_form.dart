import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sample/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:sample/domain/auth/auth_failure_or_success.dart';

import 'package:sample/presentation/sign_up/signup_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        listener: (context, state) {
      if (state.authFailureOrSuccess == AuthFailureOrSuccess.success()) {
        Get.snackbar(
          'success',
          '',
          backgroundColor: Colors.blue,
        );
      } else if (state.authFailureOrSuccess ==
          AuthFailureOrSuccess.emailAlreadyInUse()) {
        Get.snackbar(
          'Email Already In Use',
          '',
          backgroundColor: Colors.red,
        );
      } else if (state.authFailureOrSuccess ==
          AuthFailureOrSuccess.invalidEmailAndPassword()) {
        Get.snackbar(
          'Invalid Email And Password',
          '',
          backgroundColor: Colors.red,
        );
      } else if (state.authFailureOrSuccess ==
          AuthFailureOrSuccess.serverError()) {
        Get.snackbar(
          'Server error',
          '',
          backgroundColor: Colors.red,
        );
      }
    }, builder: (context, state) {
      return SingleChildScrollView(
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
                    onChanged: (value) => context
                        .read<SignInFormBloc>()
                        .add(SignInFormEvent.emailChange(value)),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "password", hintStyle: TextStyle()),
                    onChanged: (value) => context
                        .read<SignInFormBloc>()
                        .add(SignInFormEvent.passwordChange(value)),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Log in")),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(SignUpPage());
                      },
                      child: Text("Sign up"))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
