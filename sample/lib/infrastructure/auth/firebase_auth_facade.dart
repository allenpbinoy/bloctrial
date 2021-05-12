import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:sample/domain/auth/auth_failure_or_success.dart';
import 'package:sample/domain/auth/firebase_auth_result.dart';
import 'package:sample/domain/auth/i_auth_facade.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade extends IAuthFacade {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthFacade(this._firebaseAuth);

  @override
  Future<FirebaseAuthResult> registerWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);

      return FirebaseAuthResult(
        isSuccess: true,
        authFailureOrSuccess: AuthFailureOrSuccess.success(),
      );
    } catch (e) {
      FirebaseAuthException x = e as FirebaseAuthException;
      if (x.code == "email-already-in-use") {
        return FirebaseAuthResult(
          isSuccess: false,
          authFailureOrSuccess: AuthFailureOrSuccess.emailAlreadyInUse(),
        );
      } else {
        return FirebaseAuthResult(
          isSuccess: false,
          authFailureOrSuccess: AuthFailureOrSuccess.serverError(),
        );
      }
    }
  }

  @override
  Future<FirebaseAuthResult> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress, password: password);

      return FirebaseAuthResult(
        isSuccess: true,
        authFailureOrSuccess: AuthFailureOrSuccess.success(),
      );
    } catch (e) {
      FirebaseAuthException x = e as FirebaseAuthException;
      if (x.code == "ERROR_INVALID_EMAIL" || e.code == "ERROR_WRONG_PASSWORD") {
        return FirebaseAuthResult(
          isSuccess: false,
          authFailureOrSuccess: AuthFailureOrSuccess.invalidEmailAndPassword(),
        );
      } else {
        return FirebaseAuthResult(
          isSuccess: false,
          authFailureOrSuccess: AuthFailureOrSuccess.serverError(),
        );
      }
    }
  }
}
