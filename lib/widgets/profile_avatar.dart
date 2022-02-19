import 'package:facebook_ui/config/palette.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  bool isActive = false;
  ProfileAvatar({
    Key? key,
    required this.imageUrl,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        const Positioned(
          bottom: 0.0,
          right: 10.0,
          child: CircleAvatar(
            radius: 7.0,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 5.0,
              backgroundColor: Palette.online,
            ),
          ),
        ),
      ],
    );
  }
}
