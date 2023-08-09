import 'package:intl/intl.dart';
import 'package:my_childrens_voice_app/api/api.dart';

class Inpatient {
  final int id;
  final String name;
  final String birthDate;
  final String gender;
  final String personalCode;
  final bool important;

  Inpatient.fromJson(Json json)
      : id = json['id'] as int,
        name = json['name'] as String,
        birthDate = json['birthDate'] as String,
        gender = json['gender'] as String,
        personalCode = json['personalCode'] as String,
        important = json['important'] as bool;

  Json toJson() => {
        'id': id,
        'name': name,
        'birthDate': birthDate,
        'gender': gender,
        'personalCode': personalCode,
        'important': important,
      };

  int get age {
    final birth = DateFormat('yyyy-MM-dd').parse(birthDate);
    final yearDifference = DateTime.now().year - birth.year;
    final isBirthdayPassed = (birth.month - DateTime.now().month) * 31 +
            (birth.day - DateTime.now().day) <=
        0;

    return yearDifference - (isBirthdayPassed ? 0 : 1);
  }
}
