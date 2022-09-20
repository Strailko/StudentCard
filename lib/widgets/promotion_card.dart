import 'package:flutter/material.dart';
import 'package:student_card/models/user.dart' as model;
import 'package:student_card/providers/user_provider.dart';
import 'package:student_card/utils/colors.dart';
import 'package:student_card/utils/global_variable.dart';
import 'package:provider/provider.dart';

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
                          onTap: () {},
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
          GestureDetector(
            onDoubleTap: () {},
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
          Row(
            children: <Widget>[
              Flexible(
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
            ],
          ),
        ],
      ),
    );
  }
}
