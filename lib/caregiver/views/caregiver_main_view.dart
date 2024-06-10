import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_childrens_voice_app/caregiver/views/views.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

import '../screens/screens.dart';

// class CaregiverMainView extends StatelessWidget {
//   const CaregiverMainView({
//     Key? key,
//     required this.user,
//   }) : super(key: key);
//
//   final User user;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const _AppBar(),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(16).copyWith(top: 0),
//             child: Column(
//               children: [
//                 _Wrapper(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (_) => const NursingHomeSearchingScreen(),
//                       ),
//                     );
//                   },
//                   title: '요양원 등록',
//                   subtitle: '환자의 보호자가 나를 찾을 수 있도록\n요양원을 검색하고 등록해보세요',
//                   prefix: const FaIcon(
//                     FontAwesomeIcons.hospital,
//                     size: 24,
//                     color: Colors.teal,
//                   ),
//                   prefixBackgroundColor: Colors.teal.withOpacity(0.1),
//                   suffix: const Icon(Icons.keyboard_arrow_right_outlined),
//                 ),
//                 const SizedBox(height: 16),
//                 const ImportantInpatientListView(),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: _Wrapper2(
//                     backgroundColor: Colors.grey.shade50,
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (_) => const MessageSendingScreen(),
//                         ),
//                       );
//                     },
//                     title: '${user.name}님',
//                     content: Row(
//                       children: [
//                         Text('기모기모찌', style: TextStyles.subtitle),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: _Wrapper2(
//                     backgroundColor: Colors.grey.shade50,
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (_) => const ReceivedMessageListScreen(),
//                         ),
//                       );
//                     },
//                     title: '${user.name}님',
//                     content: Row(
//                       children: [
//                         Text('기모기모찌', style: TextStyles.subtitle),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CaregiverMainView extends StatelessWidget {
  const CaregiverMainView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // const _AppBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _Wrapper(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NursingHomeSearchingScreen(),
                        ),
                      );
                    },
                    title: '요양사 인증',
                    subtitle: '환자의 보호자가 나를 찾을 수 있도록\n요양사 자격을 인증하고 등록하세요',
                    prefix: const FaIcon(
                      FontAwesomeIcons.hospital,
                      size: 24,
                      color: Colors.teal,
                    ),
                    prefixBackgroundColor: Colors.teal.withOpacity(0.1),
                    suffix: const Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                  const SizedBox(height: 16),
                  const ImportantInpatientListView(),
                  const SizedBox(height: 16),
                  _Wrapper2(
                    backgroundColor: Colors.grey.shade50,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ReceivedMessageListScreen(),
                        ),
                      );
                    },
                    title: '받은 메시지',
                    content: Row(
                      children: [
                        Text(
                          '받은 보이스 메시지를 읽어드립니다',
                          style: TextStyles.subtitle.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.prefix,
    this.suffix,
    this.prefixBackgroundColor,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? prefix;
  final Widget? suffix;
  final Color? prefixBackgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrapper(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              height: 48,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        prefixBackgroundColor ?? Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: prefix,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.title,
                  ),
                  const SizedBox(height: 4),
                  if (subtitle != null)
                    Text(subtitle!, style: TextStyles.subtitle),
                ],
              ),
            ),
            if (suffix != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: suffix,
              ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: kToolbarHeight,
      child: Row(
        children: [
          Image.asset('assets/images/toss-logo.jpeg', height: 28),
          const Spacer(),
          NotificationButton(
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Wrapper2 extends StatelessWidget {
  const _Wrapper2({
    Key? key,
    required this.title,
    required this.content,
    this.backgroundColor = Colors.white,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Widget content;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: TextStyles.h1),
                const Spacer(),
                Icon(Icons.keyboard_arrow_right_outlined)
              ],
            ),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }
}
