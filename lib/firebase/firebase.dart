import 'package:firebase_auth/firebase_auth.dart';

String newUserEmail = '';
String newUserPassword = '';
String loginUserEmail = '';
String loginUserPassword = '';

Future<String?> firebaseRegist() async {
  // ユーザー登録
  String infoText = '';
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final UserCredential result = await auth.createUserWithEmailAndPassword(
      email: newUserEmail,
      password: newUserPassword,
    );
    final User user = result.user!;
    infoText = "ユーザー登録を完了しました。登録したメールアドレスは${user.email}です";
  } catch (e) {
    infoText = "ユーザー登録時にエラーが発生しました";
  }
  return infoText;
}

Future<String?> firebaseLogin() async {
  String infoText = '';
  try {
    FirebaseAuth.instance;
    // final UserCredential result = await auth.signInWithEmailAndPassword(
    //   email: loginUserEmail,
    //   password: loginUserPassword,
    // );
    // final User user = result.user!;
    //infoText = "ログインに成功しました。ログインメールアドレスは${user.email}です";
  } catch (e) {
    infoText = "ログイン時にエラーが発生しました";
  }
  return infoText;
}
