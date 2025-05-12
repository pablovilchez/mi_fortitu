import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/home/presentation/viewmodels/home_user_data_viewmodel.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/flipping_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final HomeUserDataVm userData;

  const ProfileHeader({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 140,
      child: Stack(
        children: [
          // Login field
          Positioned(
            left: 90,
            top: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/profile_header/login_field.png', height: 28),
                Positioned(
                  top: 4,
                  child: Text(
                    userData.loginName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Name field
          Positioned(
            left: 100,
            top: 52,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/profile_header/name_field.png', height: 36),
                Positioned(
                  top: 3,
                  left: 43,
                  child: Text(
                    userData.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Avatar frame
          Positioned(
            left: 16,
            top: 10,
            child: FlippingAvatar(
              frontImage: userData.customAvatar,
              backImage: userData.intraAvatar,
            ),
          ),

          // Level frame
          Positioned(
            bottom: 8,
            left: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/profile_header/level_frame.png', width: 40, height: 40),
                Positioned(
                  top: 5,
                  child: Text(
                    '${userData.level}',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stars
          Positioned(
            left: 250,
            top: 20,
            child: Row(
              children: List.generate(4, (index) {
                return Image.asset('assets/images/profile_header/star.png', width: 24, height: 24);
              }),
            ),
          ),

          // Ranking
          Positioned(
            left: 130,
            top: 95,
            child: _buildInfoChip(
              'assets/images/profile_header/ranking_field.png',
              '${userData.rank}',
            ),
          ),

          // Eval points
          Positioned(
            left: 202,
            top: 95,
            child: _buildInfoChip(
              'assets/images/profile_header/ev_points_field.png',
              '${userData.evalPoints}',
            ),
          ),

          // Altarians
          Positioned(
            left: 270,
            top: 95,
            child: _buildInfoChip(
              'assets/images/profile_header/altarians_field.png',
              userData.wallet.toString().replaceAll(
                RegExp(r'(?<=\d)(?=(\d{3})+(?!\d))'),
                tr('settings.language.thousand_separator'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String assetPath, String text) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Image.asset(assetPath, height: 36),
        Positioned(
          top: 1,
          right: 25,
          child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
