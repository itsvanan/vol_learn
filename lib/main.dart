import 'package:flutter/material.dart';
import 'package:vol_learn/pages/main_page.dart';
import 'package:vol_learn/repository/app_repository.dart';
import 'package:vol_learn/widgets/app_scope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = AppRepository();
  await repo.init();
  runApp(AppScope(repository: repo, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}
