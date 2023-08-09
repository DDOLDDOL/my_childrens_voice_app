import 'package:flutter/material.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
    required this.onSubmit,
    this.hintText = '검색어를 입력해주세요',
  }) : super(key: key);

  final void Function(String) onSubmit;
  final String hintText;

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  late final FocusNode _searchBarFocus;

  @override
  void initState() {
    super.initState();
    _searchBarFocus = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _searchBarFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4).copyWith(left: 0, right: 16),
      height: kToolbarHeight + 0.5,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const BackButton(),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  focusNode: _searchBarFocus,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: widget.onSubmit,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyles.hintText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
