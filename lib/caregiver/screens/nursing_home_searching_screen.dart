import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/home/cubits/cubits.dart';

class NursingHomeSearchingScreen extends StatelessWidget {
  const NursingHomeSearchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BlocProvider(
      create: NursingHomeSearchingCubit.create,
      child: _NursingHomeSearchingView(),
    );
  }
}

class _NursingHomeSearchingView extends StatelessWidget {
  const _NursingHomeSearchingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchAppBar(
              hintText: '지역과 요양원명을 입력하세요',
              onSubmit:
                  context.read<NursingHomeSearchingCubit>().searchNursingHome,
            ),
            Expanded(
              child: BlocBuilder<NursingHomeSearchingCubit,
                  NursingHomeSearchingState>(
                builder: (_, state) => state.maybeWhen(
                  orElse: SizedBox.shrink,
                  loaded: (nursingHomes) {
                    return ListView.builder(
                      itemCount: nursingHomes.length,
                      itemBuilder: (_, index) => SearchResultListTile(
                        title: nursingHomes[index].name,
                        subtitle: nursingHomes[index].address,
                        subtitlePrefixIcon: const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                        ),
                      ),
                    );
                  },
                  loading: LoadingView.new,
                  error: (message, reason) => ErrorView(
                    message: message,
                    reason: reason,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}