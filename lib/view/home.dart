import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_chat_app/bloc/home_bloc/bloc_home.dart';
import 'package:user_chat_app/bloc/home_bloc/home_state.dart';
import 'package:user_chat_app/services/cloud_firestore.dart';
import 'package:user_chat_app/view/signup_page.dart';
import 'package:user_chat_app/Models/UserInfo.dart' as Us;
import 'package:user_chat_app/widgets/resuable/custom_card.dart';

import '../bloc/home_bloc/home_event.dart';

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
  late String myUserID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myUserID = FirebaseAuth.instance.currentUser?.uid ?? 'no ID';
    debugPrint(myUserID);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const onLoadChatEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*
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
       */
        body: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _recentUserUpdate(),
              const Divider(
                thickness: 4.0,
                height: 0.0,
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
              _displayFriendList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayFriendList(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
        return Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.30),
          child: const CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      } else if (state is HomeSuccessStatus) {
        return _chatWidgetHolder(state.resultList, context);
      }
      return const Center(
        child: Text('Something went wrong'),
      );
    }, listener: (context, state) {
      if (state is HomeFailureStatus) {
        displayErrorToast(context);
      } else if (state is HomeSuccessStatus) {
        displaySuccessToast(context);
      }
    });
  }

  Widget _chatWidgetHolder(List<Us.UserInfo> friendList, BuildContext ctx) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (myUserID == friendList[index].uniqueId) {
            return SizedBox.shrink();
          }
          return InkWell(
            onTap: () {},
            child: Column(
              children: [
                CustomCardView(friendName: friendList[index].name),
                const Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  color: Color.fromARGB(255, 228, 221, 221),
                  thickness: 2.0,
                )
              ],
            ),
          );
        },
        itemCount: friendList.length,
      ),
    );
  }

  void displayErrorToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed to load chats.."),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
      ),
    );
  }

  void displaySuccessToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You're all set.."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _recentUserUpdate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 8.sp),
              child: Text(
                'Recent Snap',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 85.sp,
          child: Row(children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned(
                    top: 1.h,
                    child: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: 28.sp,
                      child: Icon(
                        Icons.person_4_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16.sp,
                    bottom: 26.sp,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.add_box_rounded,
                        size: 22.sp,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 12,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 13, 26, 37),
                              radius: 24.sp,
                              child: Icon(
                                Icons.person_2_outlined,
                                size: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Text(
                              'Name',
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                      ],
                    );
                  }),
            ),
          ]),
        )
      ],
    );
  }
}
