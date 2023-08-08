import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {'language': 'Please Choose a language','confirm': 'Confirm'},
    'hi_IN': {'language': 'कृपया भाषा चुनें','confirm': 'पुष्टि करना'},
    'gu_IN': {'language': 'કૃપા કરીને એક ભાષા પસંદ કરો','confirm': 'પુષ્ટિ કરો'},
    'kn_IN': {'language': 'ದಯವಿಟ್ಟು ಒಂದು ಭಾಷೆಯನ್ನು ಆಯ್ಕೆ ಮಾಡಿ','confirm': 'ದೃಢೀಕರಿಸಿ'},
  };
}
