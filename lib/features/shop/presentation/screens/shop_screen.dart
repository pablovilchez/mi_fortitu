import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home.tile.shop')),
        actions: [
          IconButton(
            onPressed: () {
              showDevInfoDialog(context, 'shopTestInfo');
            },
            icon: const Icon(Icons.adb),
            color: Colors.red,
          ),
        ],
      ),
      body: const Center(
        child: Text('Shop Screen'),
      ),
    );
  }
}