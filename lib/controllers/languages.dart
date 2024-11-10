import 'package:get/get.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'message': 'What is your name',
      'name': 'Prerit Saini', // Removed the extra space
    },
    'hi_IN': {
      'message': 'आपका क्या नाम है',
      'name': 'प्रेरित सैनी', // Removed the extra space
    },
  };
}
