import 'package:qualificationmg/importer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qualificationmg/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'view/qualificationmgTopPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '考えちう',
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //入力されたメールアドレスを入れるデータ
  String newUserEmail = '';
  //入力されたパスワードを入れるデータ
  String newUserPassword = '';
  // 登録・ログインに関する情報を表示するデータ
  String infoText = '';

  String loginUserEmail = '';
  String loginUserPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                //Emailアドレスを入力するテキストラベルを作成する
                TextField(
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (String value) => setState(() {
                    newUserEmail = value;
                  }),
                ),
                //スペースを空ける
                const SizedBox(height: 8),
                //パスワードを入力するテキストラベルを作成する
                TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  //パスワードが見えないように設定する
                  obscureText: true,
                  onChanged: (String value) => setState(() {
                    newUserPassword = value;
                  }),
                ),
                //スペースを空ける
                const SizedBox(height: 8),
                //このボタンを押すとfirebaseにユーザー情報が登録される
                ElevatedButton(
                  // Firebaseと通信するのでasyncが必要
                  onPressed: () async {
                    //ユーザー登録が無事Firebaseに登録できた場合の処理
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final UserCredential result =
                          await auth.createUserWithEmailAndPassword(
                        email: newUserEmail,
                        password: newUserPassword,
                      );

                      final User user = result.user!;
                      setState(() {
                        infoText = "ユーザー登録を完了しました。登録したメールアドレスは${user.email}です";
                      });
                    } catch (e) {
                      setState(() {
                        infoText = "ユーザー登録時にエラーが発生しました";
                      });
                    }
                  },
                  child: Text('Sign Up'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (String value) => setState(() {
                    loginUserEmail = value;
                  }),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onChanged: (String value) => setState(() {
                    loginUserPassword = value;
                  }),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // ボタンが押されたときに発動される処理
                  },
                  child: Text('ユーザー情報修正'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QualificationmgTopPage()),
                      );
                    } catch (e) {
                      setState(() {
                        infoText = 'ログイン時にエラーが発生しました';
                      });
                    }
                  },
                  child: Text('Login'),
                ),
                const SizedBox(height: 8),
                Text(infoText),
              ],
            ),
          ),
        ));
  }
}
