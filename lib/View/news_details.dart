import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:news/Controller/article_api_controller.dart';
import 'package:news/Utils/sized_box.dart';
import 'package:news/Utils/texts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    ArticlesAPIController articlesAPIController =
        Get.put(ArticlesAPIController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: articlesAPIController.searchResults.isEmpty
              ? [
                  20.height,
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 20.sp,
                        child: textWhite20w600('B'),
                      ),
                      10.width,
                      SizedBox(
                          height: 40.sp,
                          child: VerticalDivider(
                              thickness: 2.h, color: Colors.black)),
                      10.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textGrey10w600(
                              articlesAPIController.publishedDates[index]),
                          textBlack15w600(
                              '${articlesAPIController.articlesList![index].source!.name}')
                        ],
                      )
                    ],
                  ),
                  20.height,
                  textBlack25w600(
                      '${articlesAPIController.articlesList![index].title}'),
                  15.height,
                  textBlack16(
                      '${articlesAPIController.articlesList![index].content}'),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => openUrl(Uri.parse(
                              '${articlesAPIController.articlesList![index].url}')),
                          child: textBlack16Bold('Read Story')),
                      GestureDetector(
                          onTap: () => share(
                              '${articlesAPIController.articlesList![index].title}',
                              '${articlesAPIController.articlesList![index].url}'),
                          child: textBlack14Bold('Share Now')),
                    ],
                  ),
                  20.height,
                  Image.network(
                      articlesAPIController.articlesList![index].urlToImage!,
                      fit: BoxFit.fill),
                ]
              : [
                  20.height,
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 20.sp,
                        child: textWhite20w600('B'),
                      ),
                      10.width,
                      SizedBox(
                          height: 40.sp,
                          child: VerticalDivider(
                              thickness: 2.h, color: Colors.black)),
                      10.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textGrey10w600(articlesAPIController
                              .publishedSearchDates[index]),
                          textBlack15w600(
                              '${articlesAPIController.searchResults[index].source!.name}')
                        ],
                      )
                    ],
                  ),
                  20.height,
                  textRedUnderline(
                      '${articlesAPIController.searchResults[index].title}',
                      articlesAPIController.tecController.text.toLowerCase(),
                      detailsPage: true),
                  15.height,
                  textBlack16(
                      '${articlesAPIController.searchResults[index].content}'),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => openUrl(Uri.parse(
                              '${articlesAPIController.searchResults[index].url}')),
                          child: textBlack16Bold('Read Story')),
                      GestureDetector(
                          onTap: () => share(
                              '${articlesAPIController.searchResults[index].title}',
                              '${articlesAPIController.searchResults[index].url}'),
                          child: textBlack14Bold('Share Now')),
                    ],
                  ),
                  20.height,
                  Image.network(
                      articlesAPIController.searchResults[index].urlToImage!,
                      fit: BoxFit.fill),
                ],
        ),
      ),
    );
  }

  Future<void> openUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> share(String title, String url) async {
    await FlutterShare.share(title: title, linkUrl: url);
  }
}
