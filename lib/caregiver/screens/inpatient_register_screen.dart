import 'package:flutter/material.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

class InpatientRegisterScreen extends StatelessWidget {
  const InpatientRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: Text('환자 등록')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextInputField(
              title: '이름',
            ),
            const SizedBox(height: 16),
            TextInputField(
              title: '성별',
            ),
            const SizedBox(height: 16),
            TextInputField(
              title: '생년월일',
            ),
            const Spacer(),
            SubmitButton(
              onPressed: () {},
              child: const Text('등록하기'),
            ),
          ],
        ),
      ),
    );
  }
}
