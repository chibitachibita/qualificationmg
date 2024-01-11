import 'package:qualificationmg/importer.dart';

class CreateAccountPage extends ConsumerStatefulWidget {
  const CreateAccountPage({super.key, required this.title});
  final String title;
  @override
  ConsumerState<CreateAccountPage> createState() => _CreateAccountPage();
}

class _CreateAccountPage extends ConsumerState<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Create Account'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                label: Text('Name'),
                icon: Icon(Icons.account_circle),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('Mail'),
                icon: Icon(Icons.mail),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('Password'),
                icon: Icon(Icons.key),
              ),
            ),
            TextButton(
                onPressed: () {
                  // _createAccount();
                },
                child: const Text('DONE'))
          ],
        ));
  }

// // アカウント作成
//   void _createAccount(WidgetRef ref, String id, String pass) async {
//     try {
//       // credential にはアカウント情報が記録される
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: id,
//         password: pass,
//       );

//       // 非同期処理後にBuildContextをチェック
//       if (!mounted) return;

//       // ユーザ情報の更新
//       ref.watch(userProvider.state).state = credential.user;
//     } on FirebaseAuthException catch (e) {
//       // エラー処理
//       _errFirebase(e.code, ref);
//     }
//   }
}
