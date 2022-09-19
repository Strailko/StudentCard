import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_card/utils/colors.dart';
import 'package:student_card/utils/global_variable.dart';
import 'package:student_card/widgets/announcement_card.dart';
import 'package:student_card/widgets/post_card.dart';

import '../resources/auth_methods.dart';
import 'login_screen.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreen();
}

class _AnnouncementScreen extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: true,
              title: SvgPicture.asset(
                'assets/studentcard.svg',
                color: primaryColor,
                height: 32,
              ),
              leading: GestureDetector(
                onTap: () {
                  /* Write listener code here */
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back, // add custom icons also
                  color: primaryColor,
                ),
              ),
              actions: [
                // IconButton(
                //   icon: const Icon(
                //     Icons.arrow_back,
                //     color: primaryColor,
                //   ),
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                // ),
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: primaryColor,
                  ),
                  onPressed: () async {
                    await AuthMethods().signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('annoncements')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: AnnouncementCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
