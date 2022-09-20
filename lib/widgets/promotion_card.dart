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

class PromotionCard extends StatefulWidget {
  final snap;
  const PromotionCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PromotionCard> createState() => _PromotionCardState();
}

class _PromotionCardState extends State<PromotionCard> {
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
            color:
                width > webScreenSize ? secondaryColor : mobileBackgroundColor,
            width: 20),
        color: mobileBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION OF THE Promotion
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 4,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => ProfileScreen(
                            //       uid: widget.snap['uid'].toString(),
                            //     ),
                            //   ),
                            // );
                          },
                          child: Text(
                            widget.snap['name'].toString().toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    widget.snap['discount'].toString(),
                    style: const TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  padding: const EdgeInsets.only(right: 8),
                ),
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          GestureDetector(
            onDoubleTap: () {
              // FireStoreMethods().likePost(
              //   widget.snap['postId'].toString(),
              //   user.uid,
              //   widget.snap['likes'],
              // );
              // setState(() {
              //   isLikeAnimating = true;
              // });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['imageUrl'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          // LIKE, COMMENT SECTION OF THE POST
          Row(
            children: <Widget>[
              Flexible(
                // padding: const EdgeInsets.only(top: 4, left: 10),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: primaryColor),
                    children: [
                      TextSpan(
                        text: ' ${widget.snap['description']}',
                      ),
                    ],
                  ),
                  softWrap: true,
                ),
              ),

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
