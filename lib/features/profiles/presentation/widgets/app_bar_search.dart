import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/dev_info_widget.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const AppBarSearch({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: tr('search.hint'),
          border: InputBorder.none,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearch,
          ),
        ),
        IconButton(onPressed: (){
          showDevInfoDialog(context, 'searchTestInfo');
        }, icon: Icon(Icons.adb),
          color: Colors.red,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
