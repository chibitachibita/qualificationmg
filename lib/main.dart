import 'package:qualificationmg/importer.dart';
import 'dart:async';

void main() async {
  // クラッシュハンドラ
  runZonedGuarded<Future<void>>(() async {
    /// Firebaseの初期化
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // クラッシュハンドラ(Flutterフレームワーク内でスローされたすべてのエラー)
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // runApp w/ Riverpod
    runApp(const ProviderScope(child: MyApp()));
  },

      // クラッシュハンドラ(Flutterフレームワーク内でキャッチされないエラー)
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final singInStatus = ref.watch(signInStateProvider);
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

            // サインインのメッセージ表示
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(singInStatus),
            ),

            // サインイン
            TextButton(
              onPressed: () {
                _signIn(ref, idController.text, passController.text);
              },
              child: const Text('SIGN IN'),
            ),

            // アカウント作成
            TextButton(
              onPressed: () {
                // _createAccount(ref, idController.text, passController.text);
              },
              child: const Text('CREATE ACCOUNT'),
            ),

            // サインアウト
            TextButton(
                onPressed: () {
                  // _signOut(ref);
                },
                child: const Text('SIGN OUT'))
          ],
        ));
  }
}

// Authのサインイン状態のprovider
final signInStateProvider = StateProvider((ref) => 'サインイン、またはアカウントを作成してください。');

// サインインユーザーの情報プロバイダー
final userProvider = StateProvider<User?>((ref) => null);
final userEmailProvider = StateProvider<String>((ref) => 'ログインしていません');

// サインイン処理
void _signIn(WidgetRef ref, String id, String pass) async {
  try {
    /// credential にはアカウント情報が記録される
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: id,
      password: pass,
    );
    // ユーザ情報の更新
    ref.watch(userProvider.state).state = credential.user;
  } on FirebaseAuthException catch (e) {
    // サインイン失敗時エラー処理
    if (e.code == 'invalid-email') {
      ref.read(signInStateProvider.state).state = 'メールアドレスが無効です';
    }
  }
}

// // アカウント作成
// void _createAccount(WidgetRef ref, String id, String pass) async {
//   try {
//     /// credential にはアカウント情報が記録される
//     final credential =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: id,
//       password: pass,
//     );
//   } on FirebaseAuthException catch (e) {
//     // アカウント作成時エラー処理
//   }
// }
