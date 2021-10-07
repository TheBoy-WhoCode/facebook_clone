

import 'package:facebook_clone/config/palette.dart';
import 'package:facebook_clone/models/models.dart';
import 'package:facebook_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;

  const Stories({Key? key, required this.currentUser, required this.stories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _StoryCard(isAddedStory: true, currentUser: currentUser),
            );
          }
          final Story story = stories[index - 1];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _StoryCard(story: story),
          );
        },
        itemCount: 1 + stories.length,
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddedStory;
  final User? currentUser;
  final Story? story;

  const _StoryCard(
      {Key? key, this.isAddedStory = false, this.currentUser, this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              isAddedStory ? currentUser!.imageUrl : story!.imageUrl,
              // "https://images.unsplash.com/photo-1496950866446-3253e1470e8e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
              fit: BoxFit.cover,
              width: 110,
              height: double.infinity,
            )

            //   CachedNetworkImage(
            // imageUrl: isAddedStory ? currentUser.imageUrl : story.imageUrl,
            // height: double.infinity,
            // width: 110,
            // fit: BoxFit.cover,
            // ),
            ),
        Container(
          height: double.infinity,
          width: 110,
          decoration: BoxDecoration(
              gradient: Palette.storyGradient,
              borderRadius: BorderRadius.circular(12), 
              boxShadow: Responsive.isDesktop(context)
                  ? [
                      const BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4)
                    ]
                  : null),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: isAddedStory
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {
                      print("Add story");
                    },
                    icon: const Icon(Icons.add),
                    padding: EdgeInsets.zero,
                    iconSize: 30,
                    color: Palette.facebookBlue,
                  ),
                )
              : ProfileAvatar(
                  imageUrl: story!.user.imageUrl,
                  hasBorder: !story!.isViewed,
                ),
        ),
        Positioned(
            bottom: 8,
            right: 8,
            left: 8,
            child: Text(
              isAddedStory ? "Add to story" : story!.user.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );
  }
}
