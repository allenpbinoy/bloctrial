import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/infrastructure/auth/auth_failure_or_success.dart';
import 'package:sample/presentation/sign_up/sign_up_page.dart';

import '../../../application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import '../../../domain/core/value_validators.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        if (state.authFailureOrSuccess == AuthFailureOrSuccess.success()) {
          showSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.blue,
                content: Text('Success'),
              ));
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 400),
              reverseTransitionDuration: Duration(milliseconds: 400),
              pageBuilder: (context, animation, animation2) => Scaffold(),
              transitionsBuilder: (context, animation, animation2, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end);
                var curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: curve,
                );
                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                );
              },
            ),
          );
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.emailAlreadyInUse()) {
          showSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Email Already In Use'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.invalidEmailAndPassword()) {
          showSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Invalid Email And Password'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.serverError()) {
          showSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Server Error'),
              ));
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 50,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email address',
                      ),
                      autocorrect: false,
                      autofocus: false,
                      onChanged: (value) => context
                          .read<SignInFormBloc>()
                          .add(SignInFormEvent.emailChange(value)),
                      validator: (_) => validateEmailAddress(
                              context.read<SignInFormBloc>().state.emailAddress)
                          ? null
                          : state.showErrorMessages
                              ? "Invalid Email"
                              : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      autocorrect: false,
                      autofocus: false,
                      obscureText: true,
                      onChanged: (value) => context
                          .read<SignInFormBloc>()
                          .add(SignInFormEvent.passwordChange(value)),
                      validator: (_) => validatePassword(
                              context.read<SignInFormBloc>().state.password)
                          ? null
                          : 'Short Password',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Forget your password?',
                          style: TextStyle(
                            color: Color(0xff347af0),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context
                            .read<SignInFormBloc>()
                            .add(SignInFormEvent.signInWithEmailAndPassword());
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff347af0)),
                        //color: Color(0xff347af0),
                        //shape: RoundedRectangleBorder(
                        //  borderRadius: BorderRadius.circular(18),
                        //  side: BorderSide(
                        //   color: Color(0xff347af0),
                        //  ),
                        // ),
                      ),
                      child: Container(
                        width: 160,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            color: Color(0xff485068),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignUpPage();
                            }));
                          },
                          child: Text(
                            'Sign Up?',
                            style: TextStyle(
                              color: Color(0xff347af0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
