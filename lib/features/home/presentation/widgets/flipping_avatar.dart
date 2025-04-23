import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class FlippingAvatar extends StatefulWidget {
  final String frontImage;
  final String backImage;

  const FlippingAvatar({super.key, required this.frontImage, required this.backImage});

  @override
  State<FlippingAvatar> createState() => _FlippingAvatarState();
}

class _FlippingAvatarState extends State<FlippingAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFront = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _flipAvatar();
  }

  void _flipAvatar() async {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => _isFront = !_isFront);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipAvatar,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          final angle = _controller.value * pi;
          final transform =
              Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle);

          final isFrontVisible = angle <= pi / 2;

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child:
                isFrontVisible
                    ? _buildSide(widget.frontImage)
                    : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildSide(widget.backImage),
                    ),
          );
        },
      ),
    );
  }

  Widget _buildSide(String imagePath) {
    final isNetwork = imagePath.startsWith('http');
    final isLocalFile = imagePath.startsWith('/');

    final image =
        isNetwork
            ? FadeInImage.assetNetwork(
              placeholder: 'assets/images/photo_placeholder.png',
              image: imagePath,
              fit: BoxFit.cover,
            )
            : isLocalFile
            ? Image.file(File(imagePath), fit: BoxFit.cover)
            : Image.asset(imagePath, fit: BoxFit.cover);

    return ClipOval(child: SizedBox(width: 110, height: 110, child: image));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
