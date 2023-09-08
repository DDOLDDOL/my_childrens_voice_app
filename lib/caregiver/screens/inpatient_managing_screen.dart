import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/caregiver/caregiver.dart';

import '../../common/commons.dart';

class InpatientManagingScreen extends StatelessWidget {
  const InpatientManagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyInpatientCubit(
        context.read<CaregiverRepository>(),
      )..fetchMyInpatients(),
      child: const _InpatientManagingView(),
    );
  }
}

class _InpatientManagingView extends StatelessWidget {
  const _InpatientManagingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediumAppBar(
        elevated: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text('환자 관리', style: TextStyles.appBarHeadlineSmall),
            const SizedBox(width: 8),
            BlocBuilder<MyInpatientCubit, MyInpatientState>(
              builder: (_, state) {
                return state.maybeWhen(
                  orElse: SizedBox.shrink,
                  loaded: (inpatients) {
                    return Text(
                      '${inpatients.length}명',
                      style: TextStyles.subtitle.copyWith(fontSize: 18),
                    );
                  },
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: const _InpatientListView(),
    );
  }
}

class _InpatientListView extends StatelessWidget {
  const _InpatientListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyInpatientCubit, MyInpatientState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: SizedBox.shrink,
          loading: LoadingView.new,
          error: (message, reason) {
            return ErrorView(
              icon: Image.asset('assets/images/patient-error.png', width: 100),
              message: message,
              reason: reason,
              onRefresh: context.read<MyInpatientCubit>().fetchMyInpatients,
            );
          },
          loaded: (inpatients) {
            if (inpatients.isEmpty) {
              return ErrorView(
                icon: Image.asset(
                  'assets/images/patient-error.png',
                  width: 100,
                ),
                message: '등록된 환자가 없습니다',
                reason: '환자 정보를 등록해주세요',
                refreshButtonText: '환자 등록',
                onRefresh: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const InpatientRegisterScreen(),
                    ),
                  );
                },
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    itemCount: inpatients.length,
                    itemBuilder: (_, index) =>
                        InpatientListTile(inpatient: inpatients[index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(16).copyWith(top: 0),
                    child: const _CreateButton(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const InpatientRegisterScreen()),
        );
      },
      child: Wrapper(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_outlined, size: 20),
              const SizedBox(width: 4),
              Text(
                '환자 등록',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
