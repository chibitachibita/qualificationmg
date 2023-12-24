import 'package:qualificationmg/firebase/firebase.dart';
import 'package:qualificationmg/importer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:qualificationmg/firebase_options.dart';
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
  String resultText = '';
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
                    resultText = firebaseRegist() as String;
                    setState(() {
                      resultText;
                    });
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
                    resultText = firebaseLogin() as String;
                    if (resultText == '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QualificationmgTopPage()),
                      );
                    } else {
                      setState(() {
                        resultText;
                      });
                    }
                  },
                  child: Text('Login'),
                ),
                const SizedBox(height: 8),
                Text(resultText),
              ],
            ),
          ),
        ));
  }
}
