import 'package:flutter/material.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

class ImportantInpatientListTile extends StatelessWidget {
  const ImportantInpatientListTile({
    Key? key,
    required this.inpatient,
  }) : super(key: key);

  final Inpatient inpatient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.yellow.shade600, size: 20),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inpatient.name,
                style: TextStyles.title.copyWith(fontSize: 15),
              ),
              Text(
                '${inpatient.gender == "Woman" ? "여성" : "남성"}, 만 ${inpatient.age}세',
                style: TextStyles.subtitle,
              ),
            ],
          ),
          const Spacer(),
          _ChatButton(),
        ],
      ),
    );
  }
}

class _ChatButton extends StatelessWidget {
  const _ChatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          '대화',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.teal),
        ),
      ),
    );
  }
}
