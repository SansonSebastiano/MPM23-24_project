import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:room_finder/presentation/components/buttons/circle_buttons.dart';
import 'package:room_finder/style/color_palette.dart';

/// The class [AdsBox] defines all the rental proposals box that you can find in the app. 
/// To correctly invoke an [AccountPhoto] component you need to specify the following parameters:
/// - [imageUrl], one stored photo for a specific proposal;
/// - [city], facility city;
/// - [street], facility address;
/// - [price], montly price;
/// - [bookmarkButton], if specified it provides a way to save preferred ads;
/// - [onTap], specifies the redirect to the apartment page. 
class AdsBox extends StatelessWidget {
  final String imageUrl;
  final String city;
  final String street;
  final double price;
  final BookmarkButton? bookmarkButton;
  final void Function() onPressed;

  const AdsBox({
    super.key,
    required this.imageUrl,
    required this.city,
    required this.street,
    required this.price,
    this.bookmarkButton,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 337.w,
        height: 318.h,
        margin: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 198, 219, 250),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.r,
              offset: Offset(0.w, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (bookmarkButton != null)
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: bookmarkButton!,
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$city, €${price.toStringAsFixed(0)} per month',
                    style: TextStyle(
                      fontSize: 22.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    street,
                    style: TextStyle(
                      fontSize: 16.w,
                      color: ColorPalette.oxfordBlue,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'View the solution',
                    style: TextStyle(
                      fontSize: 16.w,
                      color: ColorPalette.oxfordBlue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
