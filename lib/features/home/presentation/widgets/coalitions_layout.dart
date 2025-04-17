import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/cursus_coalitions_entity.dart';

class CoalitionsLayout extends StatelessWidget {
  final CursusCoalitionsEntity coalitions;

  const CoalitionsLayout({super.key, required this.coalitions});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Expanded(
            child: ListView.builder(
              itemCount: coalitions.coalitions.length,
              itemBuilder: (context, index) {
                final coalition = coalitions.coalitions[index];
                // Number with "number_format" in json locale file
                final formattedScore = NumberFormat.decimalPattern(tr('language')).format(coalition.score);
                return Container(
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(coalition.coverUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      SvgPicture.network(coalition.imageUrl, width: 40, height: 40),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Score:', style: const TextStyle(fontSize: 16)),
                          Text(formattedScore, style: const TextStyle(fontSize: 24)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
