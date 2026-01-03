import 'package:flutter/cupertino.dart';
import 'package:vol_learn/models/word.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppService {
  Future<List<Word>> getVocabularies() async {
    String rawString = await rootBundle.loadString(
      'assets/files/vocabulary.txt',
    );
    final List<Word> result = [];
    final blocks = rawString.split(RegExp(r'\n\s*\n'));

    for (final block in blocks) {
      try {
        final lines = block.trim().split('\n');

        // Basic sanity check
        if (lines.length < 3) {
          throw FormatException('Block has less than 3 lines');
        }

        final header = lines[0].trim();
        final exampleEn = lines[1].replaceFirst('Example:', '').trim();
        final exampleVi = lines[2].replaceFirst('→', '').trim();

        final headerRegex = RegExp(
          r'^(.+?)\s+\((.+?)\)\s+[–-]\s+\((.+?)\)\s+[–-]\s+(.+?);\s+(.+)$',
        );
        final match = headerRegex.firstMatch(header);
        if (match == null) {
          throw FormatException('Invalid vocab header');
        }

        result.add(
          Word(
            word: match.group(1)!,
            partOfSpeech: match.group(2)!,
            pronunciation: match.group(3)!,
            definitionEn: match.group(4)!,
            definitionVi: match.group(5)!,
            exampleEn: exampleEn,
            exampleVi: exampleVi,
          ),
        );
      } catch (e) {
        // 👇 DO NOT crash – just log & skip
        debugPrint('⚠️ Skipped invalid vocab block:\n$block\nError: $e\n');
      }
    }

    return result;
  }
}
