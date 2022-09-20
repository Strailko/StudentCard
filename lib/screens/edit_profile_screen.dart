import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_card/resources/firestore_methods.dart';
import 'package:student_card/responsive/mobile_screen_layout.dart';
import 'package:student_card/responsive/responsive_layout.dart';
import 'package:student_card/responsive/web_screen_layout.dart';
import 'package:student_card/utils/colors.dart';
import 'package:student_card/utils/utils.dart';
import 'package:student_card/widgets/text_field_input.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image = null;
  var userData = {};

  @override
  void dispose() {
    super.dispose();
    _facultyController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = userSnap.data()!;
      _facultyController.text = userData['faculty'];
      _bioController.text = userData['bio'];
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void editUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    String res = await FireStoreMethods().editUser(
        FirebaseAuth.instance.currentUser!.uid,
        _facultyController.text,
        _bioController.text,
        _image);

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                )),
      );
    } else {
      setState(() {
        _isLoading = false;
      });

      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage('l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  _image == null &&
                          userData != {} &&
                          userData['photoUrl'] != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(userData['photoUrl']),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage('l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_photo_alternate_rounded),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  hintText: 'Faculty',
                  textInputType: TextInputType.text,
                  textEditingController: _facultyController),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'About you',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: Container(
                  child: !_isLoading
                      ? Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      : const CircularProgressIndicator(
                          color: mobileBackgroundColor,
                        ),
                  width: 150,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.white,
                  ),
                ),
                onTap: editUser,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const ResponsiveLayout(
                                  mobileScreenLayout: MobileScreenLayout(),
                                  webScreenLayout: WebScreenLayout(),
                                ))),
                    child: Container(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Container(),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
