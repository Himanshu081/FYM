import 'package:flutter/material.dart';

const Color kcprimary = Color(0xff22A45D);
const Color kcmedium = Color(0xff868686);
const kMainColor = Color(0xFFFFAAA5);
const kBackgroundColor = Color(0xFFFAFAFA);
const kBlackColor = Color(0xFF121212);
const kGreyColor = Color(0xFFAAAAAA);
const kLightGreyColor = Color(0xFFF4F4F4);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlueColor = Color(0xFF1E1E99);
const kTwentyBlueColor = Color(0x201E1E99);
const kPinkColor = Color(0xFFFF70A3);
const kTenBlackColor = Color(0x10000000);

const TextStyle ktsMediumBodyText =
    TextStyle(color: kcmedium, fontSize: kBodyTextSize);

const double kBodyTextSize = 16;

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 18.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);

//Screen Size helpers ::

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;
screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
