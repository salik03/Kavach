import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {'language': 'Please Choose a language'},
    'hi_IN': {'language': 'कृपया भाषा चुनें'},
    'gu_IN': {'language': 'કૃપા કરીને એક ભાષા પસંદ કરો'},
    'te_IN': {'language': 'దయచేసి ఒక భాషను ఎంచుకోండి'},
  };
}
