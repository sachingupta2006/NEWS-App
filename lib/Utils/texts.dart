import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textBlack30w600(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontSize: 30.sp, fontWeight: FontWeight.w600),
  );
}

Widget textBlack25w600(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontSize: 25.sp, fontWeight: FontWeight.w600),
  );
}

Widget textWhite20w600(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600),
  );
}

Widget textBlack15w600(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w600),
  );
}

Widget textGrey15w600(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.grey[600], fontSize: 15.sp, fontWeight: FontWeight.w600),
  );
}

Widget textGrey10w600(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.grey[600], fontSize: 10.sp, fontWeight: FontWeight.w600),
  );
}

Widget textBlack16(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.black, fontSize: 16.sp),
  );
}

Widget textBlack16Bold(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),
  );
}

Widget textBlack14Bold(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.bold),
  );
}

Widget textRedUnderline(String text, String searchKey,
    {bool detailsPage = false}) {
  List<String> words = text.split(' ');
  List<InlineSpan> textSpans = [];
  List<String> searchWords =
      searchKey.split(' ').map((e) => e.toLowerCase()).toList();

  for (var word in words) {
    bool shouldUnderline = searchWords.contains(word.toLowerCase());

    textSpans.add(
      TextSpan(
        text: word,
        style: TextStyle(
          color: Colors.black,
          fontSize: detailsPage ? 25.sp : 15.sp,
          fontWeight: FontWeight.w600,
          decoration:
              shouldUnderline ? TextDecoration.underline : TextDecoration.none,
          decorationColor: Colors.red,
        ),
      ),
    );
    if (word != words.last) {
      textSpans.add(const TextSpan(text: ' '));
    }
  }
  return RichText(
    text: TextSpan(children: textSpans),
  );
}
