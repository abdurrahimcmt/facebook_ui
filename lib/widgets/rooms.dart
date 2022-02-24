import 'package:facebook_ui/config/palette.dart';
import 'package:facebook_ui/models/user_model.dart';
import 'package:facebook_ui/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class Rooms extends StatelessWidget {
  final List<User> onlineUsers;
  const Rooms({Key? key, required this.onlineUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1 + onlineUsers.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: _CreateRoomButton(),
            );
          }
          User user = onlineUsers[index - 1];
          if (index < 10) {
            return ProfileAvatar(
              imageUrl: user.imageUrl,
              isActive: true,
              isBorder: false,
            );
          } else {
            return ProfileAvatar(
              imageUrl: user.imageUrl,
              isActive: false,
              isBorder: false,
            );
          }
        },
      ),
    );
  }
}

class _CreateRoomButton extends StatelessWidget {
  const _CreateRoomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            width: 3.0,
            color: Colors.blueAccent.shade100,
          ),
        ),
        shadowColor: MaterialStateProperty.all(Palette.facebookBlue),
      ),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (rect) =>
                Palette.createRoomGradient.createShader(rect),
            child: const Icon(
              Icons.video_call,
              size: 35.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 0.6,
          ),
          const Text('Create\nRoom'),
        ],
      ),
    );
  }
}
