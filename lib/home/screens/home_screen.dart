import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/authentication/authentication.dart';
import 'package:my_childrens_voice_app/authentication/cubits/user_cubit.dart';
import 'package:my_childrens_voice_app/caregiver/caregiver.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/guardian/guardian.dart';
import 'package:my_childrens_voice_app/home/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (create) =>
          UserCubit(context.read<AuthenticationRepository>())..fetchUser(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (_, state) {
            return state.maybeWhen(
              orElse: SizedBox.shrink,
              error: (message, reason) => ErrorView(
                icon: Image.asset(
                  'assets/images/user-fetch-error.png',
                  width: 100,
                ),
                message: message,
                reason: reason,
                onRefresh: context.read<UserCubit>().fetchUser,
              ),
              loading: LoadingView.new,
              loaded: (user) {
                if (user.isCaregiver) {
                  return CaregiverMainView(user: user);
                }

                return GuardianMainView(user: user);
              },
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/children.png', height: 25),
        const SizedBox(width: 8),
        Text(
          '자녀의 목소리',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const NursingHomeSearchingScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Icon(
              Icons.search_outlined,
              color: Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              '요양보호사 찾기',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
