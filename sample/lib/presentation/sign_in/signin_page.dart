import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:sample/presentation/sign_in/widgets/signin_form.dart';

import '../../injection.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: BlocProvider(
          create: (_) => getIt<SignInFormBloc>(), child: LoginForm()),
    ));
  }
}
