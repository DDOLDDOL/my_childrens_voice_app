import 'package:flutter/material.dart';

import '../styles/styles.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// default [AppBar] 입니다
  const SimpleAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
  }) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      titleTextStyle: TextStyles.appBarTitleLarge,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MediumAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MediumAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.elevated = false,
  }) : super(key: key);

  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      actions: actions,
      toolbarHeight: kToolbarHeight + 56,
      bottom: _MediumBottom(title: title, elevated: elevated),
    );
  }

  @override
  // TODO: implement preferredSize
  // == 112
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 56);
}

class _MediumBottom extends StatelessWidget implements PreferredSizeWidget {
  const _MediumBottom({
    Key? key,
    required this.title,
    required this.elevated,
  }) : super(key: key);

  final Widget title;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    var titleWidget = title;

    if (title is Text) {
      titleWidget = Text(
        (title as Text).data!,
        style: TextStyles.appBarHeadlineSmall,
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if (elevated)
            const BoxShadow(
              blurRadius: 2,
              color: Color(0xFFDDDDDD),
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: Container(
        height: 32,
        alignment: Alignment.centerLeft,
        child: titleWidget,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
