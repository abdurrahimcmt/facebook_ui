import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_ui/config/palette.dart';

import 'package:facebook_ui/models/story_model.dart';
import 'package:facebook_ui/models/user_model.dart';
import 'package:facebook_ui/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;
  const Stories({Key? key, required this.currentUser, required this.stories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return GestureDetector(
                child: _StoryCard(
                  isAddStory: false,
                  story: null,
                  user: currentUser,
                ),
              );
            } else {
              Story story = stories[index - 1];
              return _StoryCard(
                user: currentUser,
                story: story,
                isAddStory: true,
              );
            }
          }),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final User user;
  final Story? story;
  final bool isAddStory;
  const _StoryCard(
      {Key? key,
      required this.user,
      required this.story,
      required this.isAddStory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      child: isAddStory
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      width: 110.0,
                      height: double.infinity,
                      imageUrl: story!.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: Container(
                      width: 110.0,
                      height: 178.0,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    left: 8.0,
                    child: ProfileAvatar(
                      imageUrl: story!.user.imageUrl,
                      isActive: true,
                      isBorder: true,
                    ),
                  ),
                  Positioned(
                    bottom: 15.0,
                    left: 6.0,
                    child: Text(
                      story!.user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CachedNetworkImage(
                          width: 110.0,
                          height: 130.0,
                          imageUrl: user.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        const Positioned(
                          bottom: -20.0,
                          left: 30,
                          child: CircleAvatar(
                            radius: 23.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 19.0,
                              backgroundColor: Palette.facebookBlue,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Create story',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
