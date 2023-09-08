import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

class InpatientListTile extends StatelessWidget {
  const InpatientListTile({
    Key? key,
    required this.inpatient,
  }) : super(key: key);

  final Inpatient inpatient;

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inpatient.name,
                style: TextStyles.title.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(inpatient.gender),
              const SizedBox(height: 4),
              Text('만 ${inpatient.age}세'),
              const SizedBox(height: 4),
              Text(inpatient.birthDate),
              Row(
                children: [
                  Text(inpatient.personalCode),
                  const Spacer(),
                  _CopyButton(
                    onTap: () => Clipboard.setData(
                      ClipboardData(text: inpatient.personalCode),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _ChatButton(),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Star(
              onTap: () {},
              isActive: inpatient.important,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatButton extends StatelessWidget {
  const _ChatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ButtonForm(
      onTap: () {},
      color: Colors.teal.withOpacity(0.1),
      child: const Text(
        '대화',
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.teal),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  const _CopyButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return _ButtonForm(
      onTap: onTap,
      color: Colors.blue.withOpacity(0.1),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.copy_outlined, size: 16, color: Colors.blue),
          SizedBox(width: 8),
          Text(
            '코드 복사',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class _ButtonForm extends StatelessWidget {
  const _ButtonForm({
    Key? key,
    required this.color,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final void Function()? onTap;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
