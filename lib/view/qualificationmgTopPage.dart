import 'package:qualificationmg/importer.dart';

class QualificationmgTopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('上に表示される'),
      ),
      body: Center(
        child: Text('まんなか'),
      ),
    );
  }
}
