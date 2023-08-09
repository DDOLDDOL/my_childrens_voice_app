import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/home/home.dart';

class CaregiverSearchingScreen extends StatelessWidget {
  const CaregiverSearchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _CaregiverSearchingView();
  }
}

class _CaregiverSearchingView extends StatelessWidget {
  const _CaregiverSearchingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: Column(
      //     children: [
      //       SearchAppBar(
      //         onSubmit:
      //             context.read<NursingHomeSearchingCubit>().searchNursingHome,
      //       ),
      //       Expanded(
      //         child: BlocBuilder<NursingHomeSearchingCubit,
      //             NursingHomeSearchingState>(
      //           builder: (_, state) => state.maybeWhen(
      //             orElse: SizedBox.shrink,
      //             loaded: (nursingHomes) {
      //               return ListView.builder(
      //                 itemCount: nursingHomes.length,
      //                 itemBuilder: (_, index) => SearchResultListTile(
      //                   title: nursingHomes[index].name,
      //                   subtitle: nursingHomes[index].address,
      //                   subtitlePrefixIcon: const Icon(
      //                     Icons.location_on_outlined,
      //                     size: 15,
      //                   ),
      //                 ),
      //               );
      //             },
      //             loading: _LoadingView.new,
      //             error: (message, reason) => _ErrorView(
      //               message: message,
      //               reason: reason,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

