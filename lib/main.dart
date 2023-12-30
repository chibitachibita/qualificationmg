import 'package:qualificationmg/importer.dart';

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
      title: 'Auth Page',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const MyHomePage(
        title: 'Auth Page',
      ),
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
  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();
    final passController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Auth Page'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            // メールアドレス入力
            TextField(
              decoration: const InputDecoration(
                label: Text('mail'),
                icon: Icon(Icons.mail),
              ),
              controller: idController,
            ),

            // パスワード入力
            TextField(
              decoration: const InputDecoration(
                label: Text('Password'),
                icon: Icon(Icons.key),
              ),
              controller: passController,
              obscureText: true,
            ),

            // サインイン
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // _signIn(ref, idController.text, passController.text);
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.zero), // パディングをゼロに設定
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // ボタンのサイズを内容に合わせる
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: const Text('サインイン'),
              ),
            ),
          ],
        ));
  }
}
