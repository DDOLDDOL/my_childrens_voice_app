import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchResultListTile extends StatelessWidget {
  const SearchResultListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.subtitlePrefixIcon,
    this.onTap,
  }) : super(key: key);

  final Widget? subtitlePrefixIcon;
  final String title;
  final String subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _titleStyle),
            const SizedBox(height: 8),
            Row(
              children: [
                if (subtitlePrefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: subtitlePrefixIcon!,
                  ),
                Expanded(child: Text(subtitle, style: _subtitleStyle)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _titleStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _subtitleStyle => const TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.2,
      );
}
