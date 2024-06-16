// ignore: avoid_classes_with_only_static_members
class DaysOfWeekGenerator {

  static bool isDayMonth = true;
  static bool isDayWeek = false;

  static List<int> daysofWeekValueForValidation = [];

  static List<int> daysValueForValidation = [];

  static List<int> orderDaysForValidation = [];

  static final List<String> daysOfWeekInList = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье'
  ];

  static final Map<String, int> daysOfWeekToValidation = {
    'Понедельник': 1,
    'Вторник': 2,
    'Среда': 3,
    'Четверг': 4,
    'Пятница': 5,
    'Суббота': 6,
    'Воскресенье': 7,
  };

  final Map<String, bool> daysOfWeek = {
    'Понедельник': false,
    'Вторник': false,
    'Среда': false,
    'Четверг': false,
    'Пятница': false,
    'Суббота': false,
    'Воскресенье': false,
  };

  final Map<String, bool> daysOfWeekToBytesBool = {
    'Первый': false,
    'Второй': false,
    'Третий': false,
    'Четвертый': false,
    'Последний': false,
  };

  final Map<String, int> daysOfWeekToBytesNum = {
    'Первый': 0,
    'Второй': 1,
    'Третий': 2,
    'Четвертый': 3,
    'Последний': 4,
  };

   final Map<String, int> daysOfWeekToChecked = {
    'Понедельник': 0,
    'Вторник': 0,
    'Среда': 0,
    'Четверг': 0,
    'Пятница': 0,
    'Суббота': 0,
    'Воскресенье': 0,
  };

  static final Map<int, int> daysToValidation = {
    1:1,
    2:2,
    3:3,
    4:4,
    5:5,
    6:6,
    7:7,
    8:8,
    9:9,
    10:10,
    11:11,
    12:12,
    13:13,
    14:14,
    15:15,
    16:16,
    17:17,
    18:18,
    19:19,
    20:20,
    21:21,
    22:22,
    23:23,
    24:24,
    25:25,
    26:26,
    27:27,
    28:28,
    29:29,
    30:30,
    31:31,
  };

   final Map<int, bool> days = {
    1:false,
    2:false,
    3:false,
    4:false,
    5:false,
    6:false,
    7:false,
    8:false,
    9:false,
    10:false,
    11:false,
    12:false,
    13:false,
    14:false,
    15:false,
    16:false,
    17:false,
    18:false,
    19:false,
    20:false,
    21:false,
    22:false,
    23:false,
    24:false,
    25:false,
    26:false,
    27:false,
    28:false,
    29:false,
    30:false,
    31:false,
  };

   final Map<int, int> daysToChecked = {
    1:0,
    2:0,
    3:0,
    4:0,
    5:0,
    6:0,
    7:0,
    8:0,
    9:0,
    10:0,
    11:0,
    12:0,
    13:0,
    14:0,
    15:0,
    16:0,
    17:0,
    18:0,
    19:0,
    20:0,
    21:0,
    22:0,
    23:0,
    24:0,
    25:0,
    26:0,
    27:0,
    28:0,
    29:0,
    30:0,
    31:0,
  };
}