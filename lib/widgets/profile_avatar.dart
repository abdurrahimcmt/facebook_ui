import 'package:facebook_ui/config/palette.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool isBorder;
  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    required this.isActive,
    required this.isBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: isBorder
                ? CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Palette.facebookBlue,
                    child: CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  )
                : CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(imageUrl),
                  )),
        isActive
            ? const Positioned(
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
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
