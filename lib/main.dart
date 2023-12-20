import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qualificationmg/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  //入力されたメールアドレスを入れるデータ
  String newUserEmail = '';
  //入力されたパスワードを入れるデータ
  String newUserPassword = '';
  // 登録・ログインに関する情報を表示するデータ
  String infoText = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
              ],
            ),
          ),
        ));
  }
}
