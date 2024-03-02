import '../constants/value.dart';

const Map<String, Map<String, String>> languageData = {
  'AppName': {
    'English': 'QBangla Dictionary pro',
    'বাংলা': 'কিউ বাংলা ডিকশনারী প্রো'
  },
  'SearchWordHere': {
    'English': 'Search word here...',
    'বাংলা': 'এখানে অনুসন্ধান করুন...'
  },
  'AboutUs': {'English': 'About Us', 'বাংলা': 'আমাদের সম্পর্কে'},
  'Language': {'English': 'Language', 'বাংলা': 'ভাষা'},
  'Theme': {'English': 'Theme', 'বাংলা': 'থিম'},
  'Clear': {'English': 'Clear', 'বাংলা': 'মুছুন'},
  'Synonym': {'English': 'Synonym', 'বাংলা': 'সমার্থক শব্দ'},
  'Antonym': {'English': 'Antonym', 'বাংলা': 'বিপরীত শব্দ'},
  'Example': {'English': 'Example', 'বাংলা': 'উদাহরণ'},
  'Definition': {'English': 'Definition', 'বাংলা': 'সংজ্ঞা'},
  'DevInfo': {'English': 'Dev Info', 'বাংলা': 'ডেভ পরিচিতি'},
  'Speak': {'English': 'Speak', 'বাংলা': 'স্পিক'},
  'PoS': {'English': 'Part of Speech', 'বাংলা': 'বাক্যের অংশ'},
  'Close': {'English': 'Close', 'বাংলা': 'ক্লোজ'},
  'Past': {'English': 'Past', 'বাংলা': 'পেস্ট'},
  'Type': {'English': 'Type', 'বাংলা': 'প্রকার'},
  'Meaning': {'English': 'Meaning', 'বাংলা': 'অর্থ'},
  'More': {'English': 'More', 'বাংলা': 'আরও'},
  'Version': {'English': 'V6', 'বাংলা': 'V6'},
};

String tr(String name) {
  return languageData[name]![currentLang].toString();
}
