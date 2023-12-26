import 'package:firebase_auth/firebase_auth.dart';

// FirebaseAuthから発生する例外をenumで定義
enum FirebaseAuthResultStatus {
  Successful,
  EmailAlreadyExists,
  WrongPassword,
  InvalidEmail,
  UserNotFound,
  UserDisabled,
  OperationNotAllowed,
  TooManyRequests,
  Undefined,
}
