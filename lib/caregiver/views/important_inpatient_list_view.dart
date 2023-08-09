import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/caregiver/caregiver.dart';
import 'package:my_childrens_voice_app/caregiver/screens/inpatient_managing_screen.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

import '../cubits/cubits.dart';
import '../repository/repository.dart';

class ImportantInpatientListView extends StatelessWidget {
  const ImportantInpatientListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyInpatientCubit(
        context.read<CaregiverRepository>(),
      )..fetchMyInpatients(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const _Header(),
          BlocBuilder<MyInpatientCubit, MyInpatientState>(
            builder: (_, state) {
              return state.maybeWhen(
                orElse: SizedBox.shrink,
                loaded: (inpatients) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 200),
                    child: _ListView(
                      // inpatients: inpatients
                      //     .where((inpatient) => inpatient.important)
                      //     .toList()
                      inpatients: [
                        ...inpatients
                            .where((inpatient) => inpatient.important)
                            .toList(),
                        ...inpatients
                            .where((inpatient) => inpatient.important)
                            .toList(),
                        ...inpatients
                            .where((inpatient) => inpatient.important)
                            .toList(),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const InpatientManagingScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text('환자 관리', style: TextStyles.h1),
            const Spacer(),
            Icon(Icons.keyboard_arrow_right_outlined),
          ],
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({
    Key? key,
    required this.inpatients,
  }) : super(key: key);

  final List<Inpatient> inpatients;

  @override
  Widget build(BuildContext context) {
    if (inpatients.isEmpty) {
      return const Center(child: Text('중요 설정 환자가 없습니다'));
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: inpatients.length,
      itemBuilder: (_, index) =>
          ImportantInpatientListTile(inpatient: inpatients[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }
}
