import 'package:flutter/material.dart';
import 'package:student_card/models/user.dart' as model;
import 'package:student_card/providers/user_provider.dart';
import 'package:student_card/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

    return ListTile(
      title: Text(
        widget.snap['title'].toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                left: 0,
              ),
              child: Flexible(
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
            )),
            Container(
              child: Text(
                DateFormat.yMMMd()
                    .format(widget.snap['datePublished'].toDate()),
                style: const TextStyle(
                  color: secondaryColor,
                ),
                textAlign: TextAlign.right,
                softWrap: true,
              ),
              padding: const EdgeInsets.only(right: 8),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
