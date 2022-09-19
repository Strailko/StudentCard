import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_card/models/user.dart' as model;
import 'package:student_card/providers/user_provider.dart';
import 'package:student_card/resources/firestore_methods.dart';
import 'package:student_card/screens/comments_screen.dart';
import 'package:student_card/utils/colors.dart';
import 'package:student_card/utils/global_variable.dart';
import 'package:student_card/utils/utils.dart';
import 'package:student_card/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/profile_screen.dart';

class AnnouncementCard extends StatefulWidget {
  final snap;
  const AnnouncementCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return Container(
      // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
        ),
        color: mobileBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION OF THE Announcement
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          uid: widget.snap['uid'].toString(),
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.snap['imageUrl'].toString(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  uid: widget.snap['uid'].toString(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            widget.snap['title'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   child: Text(
                //     DateFormat.yMMMd()
                //         .format(widget.snap['datePublished'].toDate()),
                //     style: const TextStyle(
                //       color: secondaryColor,
                //     ),
                //   ),
                //   padding: const EdgeInsets.only(right: 8),
                // ),
                // widget.snap['uid'].toString() == user.uid
                //     ? IconButton(
                //         onPressed: () {
                //           showDialog(
                //             useRootNavigator: false,
                //             context: context,
                //             builder: (context) {
                //               return Dialog(
                //                 child: ListView(
                //                     padding: const EdgeInsets.symmetric(
                //                         vertical: 16),
                //                     shrinkWrap: true,
                //                     children: [
                //                       'Delete',
                //                     ]
                //                         .map(
                //                           (e) => InkWell(
                //                               child: Container(
                //                                 padding:
                //                                     const EdgeInsets.symmetric(
                //                                         vertical: 12,
                //                                         horizontal: 16),
                //                                 child: Text(e),
                //                               ),
                //                               onTap: () {
                //                                 deletePost(
                //                                   widget.snap['postId']
                //                                       .toString(),
                //                                 );
                //                                 // remove the dialog box
                //                                 Navigator.of(context).pop();
                //                               }),
                //                         )
                //                         .toList()),
                //               );
                //             },
                //           );
                //         },
                //         icon: const Icon(Icons.settings),
                //       )
                //     : Container(),
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          // GestureDetector(
          //   onDoubleTap: () {
          //     FireStoreMethods().likePost(
          //       widget.snap['postId'].toString(),
          //       user.uid,
          //       widget.snap['likes'],
          //     );
          //     setState(() {
          //       isLikeAnimating = true;
          //     });
          //   },
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.35,
          //         width: double.infinity,
          //         child: Image.network(
          //           widget.snap['postUrl'].toString(),
          //           fit: BoxFit.contain,
          //         ),
          //       ),
          //       AnimatedOpacity(
          //         duration: const Duration(milliseconds: 200),
          //         opacity: isLikeAnimating ? 1 : 0,
          //         child: LikeAnimation(
          //           isAnimating: isLikeAnimating,
          //           child: const Icon(
          //             Icons.thumb_up,
          //             color: Colors.white,
          //             size: 100,
          //           ),
          //           duration: const Duration(
          //             milliseconds: 400,
          //           ),
          //           onEnd: () {
          //             setState(() {
          //               isLikeAnimating = false;
          //             });
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // LIKE, COMMENT SECTION OF THE POST
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 4, left: 10),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: primaryColor),
                    children: [
                      TextSpan(
                        text: ' ${widget.snap['description']}',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
              )),
              // LikeAnimation(
              //   isAnimating: widget.snap['likes'].contains(user.uid),
              //   smallLike: true,
              //   child: IconButton(
              //     icon: widget.snap['likes'].contains(user.uid)
              //         ? const Icon(
              //             Icons.thumb_up,
              //             color: Colors.blue,
              //           )
              //         : const Icon(
              //             Icons.thumb_up_outlined,
              //           ),
              //     onPressed: () => FireStoreMethods().likePost(
              //       widget.snap['postId'].toString(),
              //       user.uid,
              //       widget.snap['likes'],
              //     ),
              //   ),
              // ),
              // DefaultTextStyle(
              //     style: Theme.of(context)
              //         .textTheme
              //         .subtitle2!
              //         .copyWith(fontWeight: FontWeight.w800),
              //     child: Text(
              //       '${widget.snap['likes'].length} likes',
              //       style: Theme.of(context).textTheme.bodyText2,
              //     )),
              // IconButton(
              //   icon: const Icon(
              //     Icons.comment_outlined,
              //   ),
              //   onPressed: () => Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => CommentsScreen(
              //         postId: widget.snap['postId'].toString(),
              //       ),
              //     ),
              //   ),
              // ),
              // DefaultTextStyle(
              //     style: Theme.of(context)
              //         .textTheme
              //         .subtitle2!
              //         .copyWith(fontWeight: FontWeight.w800),
              //     child: Text(
              //       '$commentLen comments',
              //       style: Theme.of(context).textTheme.bodyText2,
              //     )),
              // Container(
              //   padding: const EdgeInsets.only(top: 4, left: 10),
              // ),
            ],
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS
        ],
      ),
    );
  }
}
