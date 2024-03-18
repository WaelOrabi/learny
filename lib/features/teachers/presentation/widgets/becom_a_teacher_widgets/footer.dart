
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget footer(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(40).w,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff16D9E3),
          Color(0xff30C7EC),
          Color(0xff46AEF7),
        ],
      ),
    ),
    child: IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Row(

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 40.w,
                      backgroundImage: const AssetImage(
                        'assets/images/logo_white.png',
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      "Learny",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.sp,
                      ),
                    ),
                    // Add more widgets here
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Learny platform offers\n you the best to be the\n best and distinguished\n among your friends.",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                )
              ],
            ),
            SizedBox(
              width: 100.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "  Sitemap",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextButton(
                    onPressed: () {},
                    child:  Text(
                      "  Home",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    )),
                SizedBox(
                  height: 5.h,
                ),
                TextButton(
                    onPressed: () {},
                    child:  Text(
                      "     Teachers",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    )),
                SizedBox(
                  height: 5.h,
                ),
                TextButton(
                    onPressed: () {},
                    child:  Text(
                      "  Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    )),
                SizedBox(
                  height: 5.h,
                ),
                TextButton(
                    onPressed: () {},
                    child:  Text(
                      "  Rooms",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ))
              ],
            ),
            SizedBox(
              width: 100.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  About us",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextButton(
                    onPressed: () {},
                    child:  Text(
                      "Read about us",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ))
              ],
            ),
            SizedBox(
              width: 100.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  "Contact us",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "ayhamalrefay@gmail.com",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "+963933773538",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
