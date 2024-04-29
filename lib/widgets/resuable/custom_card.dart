import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardView extends StatelessWidget {
  final String? imgUrl;
  final String? upfrontMessage;
  final String? timeStamp;
  final String friendName;

  CustomCardView({
    required this.friendName,
    this.timeStamp,
    this.imgUrl,
    this.upfrontMessage,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 8.sp,
      color: Color.fromARGB(255, 13, 26, 37),
      shadowColor: const Color.fromARGB(255, 115, 113, 113),
      margin: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 1.sp),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.sp,
          vertical: 10.sp,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 20,
              child: CircleAvatar(
                radius: 24.sp,
                child: Icon(
                  Icons.person_2_outlined,
                  color: Colors.red,
                ),
              ),
            ),
            Expanded(
              flex: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    friendName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'messages here...',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 16,
              child: Text(
                '12:22 AM',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
