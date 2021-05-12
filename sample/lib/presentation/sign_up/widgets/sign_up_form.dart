import 'package:sample/application/auth/sign_up_form/bloc/sign_up_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/infrastructure/auth/auth_failure_or_success.dart';

import '../../../domain/core/value_validators.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listener: (context, state) {
        print(state);
        if (state.authFailureOrSuccess == AuthFailureOrSuccess.success()) {
          showSnackBarNow(
              context,
              SnackBar(
                backgroundColor: Colors.blue,
                content: Text('Success'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.emailAlreadyInUse()) {
          showSnackBarNow(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Email Already In Use'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.invalidEmailAndPassword()) {
          showSnackBarNow(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Invalid Email And Password'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.serverError()) {
          showSnackBarNow(
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
            // autovalidate: state.showErrorMessages,
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
                      onChanged: (value) {
                        BlocProvider.of<SignUpFormBloc>(context, listen: false)
                            .add(SignUpFormEvent.emailChange(value));
                      },
                      validator: (_) => validateEmailAddress(
                              BlocProvider.of<SignUpFormBloc>(context,
                                      listen: false)
                                  .state
                                  .emailAddress)
                          ? null
                          : "Invalid Email",
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      autocorrect: false,
                      autofocus: false,
                      obscureText: true,
                      onChanged: (value) => BlocProvider.of<SignUpFormBloc>(
                              context,
                              listen: false)
                          .add(SignUpFormEvent.passwordChange(value)),
                      validator: (_) => validatePassword(
                              BlocProvider.of<SignUpFormBloc>(context,
                                      listen: false)
                                  .state
                                  .password)
                          ? null
                          : 'Short Password',
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<SignUpFormBloc>().add(
                            SignUpFormEvent.registerWithEmailAndPassword());
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(
                                color: Color(0xff347af0),
                              ),
                            ),
                          )),
                      child: Container(
                        width: 160,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'Let\'s Get Started',
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
                          'Already have an account? ',
                          style: TextStyle(
                            color: Color(0xff485068),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login?',
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

  void showSnackBarNow(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
