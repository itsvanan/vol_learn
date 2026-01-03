import 'dart:math';

import 'package:vol_learn/models/word.dart';
import 'package:vol_learn/services/app_service.dart';

class AppRepository {
  AppRepository._internal();
  static final AppRepository _instance = AppRepository._internal();
  factory AppRepository() => _instance;
  List<Word> _words = [];
  final _random = Random();

  Future<void> init() async {
    _words = await AppService().getVocabularies();
  }

  Word getRandom() {
    return _words[_random.nextInt(_words.length)];
  }

  Word getByIndex(int index) {
    return _words[index % _words.length];
  }
}
