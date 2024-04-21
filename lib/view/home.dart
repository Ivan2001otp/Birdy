import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_chat_app/services/cloud_firestore.dart';
import 'package:user_chat_app/view/signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum MenuValues {
  LogOut,
  Setting,
  Profile,
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.sp,
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton<MenuValues>(onSelected: (selectedVal) {
              switch (selectedVal) {
                case MenuValues.LogOut:
                  FirestoreCloud().logOutUser();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                  break;

                case MenuValues.Profile:
                  break;

                case MenuValues.Setting:
                  break;
              }
            }, itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Log Out'),
                  value: MenuValues.LogOut,
                ),
                PopupMenuItem(
                  child: Text('Profile'),
                  value: MenuValues.Profile,
                ),
                PopupMenuItem(
                  child: Text('Setting'),
                  value: MenuValues.Setting,
                ),
              ];
            })
          ],
        ),
        body: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _recentUserUpdate(),
              _displayFriendList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayFriendList(BuildContext context) {
    return SizedBox();
  }

  Widget _recentUserUpdate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.sp, vertical: 8.sp),
                child: Text('Recent Update')),
          ],
        ),
        SizedBox(
          height: 500.sp,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24.sp,
                          child: Icon(
                            Icons.person_2_outlined,
                            size: 18.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4.sp,
                        ),
                        Text('Name'),
                      ],
                    ),
                    SizedBox(
                      width: 8.sp,
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }
}
