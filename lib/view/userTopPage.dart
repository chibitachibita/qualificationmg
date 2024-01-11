import 'package:qualificationmg/importer.dart';

class UserTopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('MyPage'),
      ),
      body: Center(
        child: Text('開発ちう'),
      ),
    );
  }
}
