import 'package:flutter/material.dart';
import 'package:vol_learn/models/word.dart';
import 'package:vol_learn/repository/app_repository.dart';
import 'package:vol_learn/widgets/app_scope.dart';
import 'package:vol_learn/widgets/word_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Word? _word;
  late AppRepository _repository;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    _repository = AppScope.of(context).repository;
    initWord();
    _initialized = true;
  }

  void initWord() {
    _word = _repository.getRandom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child:
            _word != null
                ? Center(
                  child: VocabularyCard(
                    word: _word!.word,
                    partOfSpeech: _word!.partOfSpeech,
                    pronunciation: _word!.pronunciation,
                    definition: _word!.definitionEn,
                    translation: _word!.definitionVi,
                    example: _word!.exampleEn,
                    exampleTranslation: _word!.exampleVi,
                    accentColor: const Color(0xFF6366F1),
                  ),
                )
                : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initWord();
          setState(() {});
        },
        child: Text("Get"),
      ),
    );
  }
}
