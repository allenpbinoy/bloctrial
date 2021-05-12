import 'package:flutter/services.dart';
import 'package:sample/infrastructure/auth/auth_failure_or_success.dart';
import 'package:sample/presentation/sign_in/sign_in_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import '../../injection.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SignInFormBloc bloc = getIt<SignInFormBloc>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    autoLogin();
    super.didChangeDependencies();
  }

  autoLogin() async {
    bloc.add(SignInFormEvent.autoLogin());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return BlocListener<SignInFormBloc, SignInFormState>(
        bloc: bloc,
        listener: (context, state) {
          if (!state.isSubmitting &&
              state.autoLoginStatus &&
              state.authFailureOrSuccess == AuthFailureOrSuccess.success()) {
            print(
                "User found => Redirecting -> Home ${FirebaseAuth.instance.currentUser}");
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Scaffold()));
          } else if (!state.isSubmitting &&
              state.autoLoginStatus &&
              state.authFailureOrSuccess == AuthFailureOrSuccess.none()) {
            print("User not found => Redirecting -> SignIn");
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignInPage()));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Yuthi',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
