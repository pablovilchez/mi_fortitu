import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';

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
      backgroundColor: Colors.transparent,
      title: SizedBox(
        height: 50,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          decoration: InputDecoration(
            hintText: tr('profile.search.hint'),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
          ),
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
