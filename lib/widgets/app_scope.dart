import 'package:flutter/cupertino.dart';
import 'package:vol_learn/repository/app_repository.dart';

class AppScope extends InheritedWidget {
  final AppRepository repository;

  const AppScope({required this.repository, required super.child, super.key});

  static AppScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppScope>()!;
  }

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) {
    return repository != oldWidget.repository;
  }
}
