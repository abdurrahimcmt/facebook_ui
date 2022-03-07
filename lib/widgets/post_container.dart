import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_ui/data/data.dart';
import 'package:facebook_ui/models/models.dart';
import 'package:facebook_ui/models/post_model.dart';
import 'package:facebook_ui/widgets/profile_avatar.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  final User currentUser;
  PostContainer({
    Key? key,
    required this.post,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PostHeader(post: post),
              post.caption.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text(post.caption),
                      ],
                    ),
              post.imageUrl != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CachedNetworkImage(
                        imageUrl: post.imageUrl!,
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 12.0,
              ),
              _PostFooter(post: post),
              Divider(
                color: Colors.grey.shade600,
                thickness: 1,
              ),
              _PostComment(post: post, currentUser: currentUser),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(post.user.imageUrl),
          radius: 22.0,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    post.timeAgo + ' .',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey.shade600,
                    size: 12.0,
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_horiz,
            color: Colors.grey.shade600,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.clear,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _PostFooter extends StatelessWidget {
  final Post post;
  const _PostFooter({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 45.0,
              child: Stack(
                clipBehavior: Clip.none,
                children: const [
                  CircleAvatar(
                    radius: 12.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 10,
                      child: Icon(
                        Icons.thumb_up,
                        size: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18.0,
                    child: CircleAvatar(
                      radius: 12.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.favorite,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                '${post.likes}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            Text(
              '${post.comments} Comments',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              '${post.likes} Share',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
        Divider(
          color: Colors.grey.shade600,
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _PostButton(
              icon: Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.grey.shade600,
                size: 25.0,
              ),
              label: 'Like',
              ontap: () {},
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey.shade600,
                size: 25.0,
              ),
              label: 'Comment',
              ontap: () {},
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey.shade600,
                size: 25.0,
              ),
              label: 'Share',
              ontap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function() ontap;
  const _PostButton(
      {Key? key, required this.icon, required this.label, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          height: 25.0,
          child: Row(
            children: [
              icon,
              SizedBox(
                width: 8.0,
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostComment extends StatelessWidget {
  final Post post;
  final User currentUser;
  const _PostComment({Key? key, required this.post, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          ProfileAvatar(
            imageUrl: currentUser.imageUrl,
            isActive: true,
            isBorder: false,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      hintText: 'Write a comment...',
                      fillColor: Color.fromARGB(255, 245, 241, 241),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  top: 10.0,
                  child: Container(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey.shade500,
                        ),
                        Icon(
                          MdiIcons.gift,
                          color: Colors.grey.shade500,
                        ),
                        Icon(
                          MdiIcons.stickerEmoji,
                          color: Colors.grey.shade500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
