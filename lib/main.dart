import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Routes/routes.dart';

// 38203352c7d948f6b1b0e5277e1421e3
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) {
          return GetMaterialApp(
              title: 'NEWS',
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              getPages: AppRoutes.appRoutes());
        },
        designSize: const Size(360, 800));
  }
}
