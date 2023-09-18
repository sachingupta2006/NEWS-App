import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news/Controller/article_api_controller.dart';
import 'package:news/Utils/sized_box.dart';
import 'package:news/Utils/texts.dart';
import 'news_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    ArticlesAPIController articlesAPIController =
        Get.put(ArticlesAPIController());
    articlesAPIController.getApi();
  }

  @override
  Widget build(BuildContext context) {
    RxBool politics = true.obs;
    RxBool movies = false.obs;
    RxBool sports = false.obs;
    RxBool crime = false.obs;
    ArticlesAPIController articlesAPIController =
        Get.put(ArticlesAPIController());
    return GetBuilder<ArticlesAPIController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: textBlack30w600('NEWS'),
          actions: [
            textBlack15w600(articlesAPIController.todaysDate),
            SizedBox(width: 5.w)
          ],
        ),
        body: articlesAPIController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.height,
                    textGrey15w600('Hey, James!'),
                    10.height,
                    textBlack30w600('Discover Latest News'),
                    15.height,
                    Row(children: [
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width - 32.w - 50.h,
                          child: TextFormField(
                              // onChanged: (value) {
                              //   articlesAPIController.searchMethod();
                              // },
                              controller: articlesAPIController.tecController,
                              decoration: const InputDecoration(
                                  hintText: 'Search For News'))),
                      GestureDetector(
                        onTap: () {
                          articlesAPIController.searchMethod();
                        },
                        child: Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Icon(Icons.search,
                                    color: Colors.white, size: 15.sp))),
                      )
                    ]),
                    20.height,
                    Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              filterWidget(
                                  'Politics', Icons.mic_none, politics.value,
                                  () {
                                politics.value = true;
                                movies.value = false;
                                sports.value = false;
                                crime.value = false;
                              }),
                              filterWidget(
                                  'Movies',
                                  Icons.local_movies_outlined,
                                  movies.value, () {
                                politics.value = false;
                                movies.value = true;
                                sports.value = false;
                                crime.value = false;
                              }),
                              filterWidget(
                                  'Sports',
                                  Icons.sports_cricket_outlined,
                                  sports.value, () {
                                politics.value = false;
                                movies.value = false;
                                sports.value = true;
                                crime.value = false;
                              }),
                              filterWidget('Crime', Icons.cut, crime.value, () {
                                politics.value = false;
                                movies.value = false;
                                sports.value = false;
                                crime.value = true;
                              })
                            ])),
                    20.height,
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 500.h,
                        child: ListView.builder(
                            itemCount: articlesAPIController
                                    .searchResults.isNotEmpty
                                ? articlesAPIController.searchResults.length
                                : articlesAPIController.articlesList!.length,
                            itemBuilder: (context, index) {
                              return articlesAPIController
                                      .searchResults.isNotEmpty
                                  ? contentWidget(
                                      index,
                                      textRedUnderline(
                                          articlesAPIController
                                              .searchResults[index].title!,
                                          articlesAPIController
                                              .tecController.text.toLowerCase()),
                                      articlesAPIController
                                          .publishedSearchDates[index],
                                      articlesAPIController
                                          .suffixSearchSubtitle[index],
                                      articlesAPIController
                                          .searchResults[index].urlToImage!)
                                  : contentWidget(
                                      index,
                                      textBlack15w600(
                                          '${articlesAPIController.articlesList![index].title}'),
                                      '${articlesAPIController.publishedDates[index]}',
                                      articlesAPIController
                                          .suffixSubtitle[index],
                                      '${articlesAPIController.articlesList![index].urlToImage}');
                            }),
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }

  Widget contentWidget(int index, Widget title, String publishedAt,
      String suffixSubtitle, String image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Get.to(NewsDetails(
            index: index,
          )),
          child: ListTile(
            leading: Image.network(image,
                fit: BoxFit.fill, height: 90.h, width: 90.h),
            title: title,
            subtitle: textGrey10w600('$publishedAt • $suffixSubtitle'),
          ),
        ),
        15.height
      ],
    );
  }

  Widget filterWidget(
      String title, IconData iconData, bool selected, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: selected ? Colors.red[100] : Colors.grey[200],
            radius: 20.sp,
            child: Icon(iconData,
                color: selected ? Colors.red : Colors.black, size: 15.sp),
          ),
          10.height,
          Text(
            title,
            style: TextStyle(
                fontSize: 15.sp, color: selected ? Colors.black : Colors.grey),
          )
        ],
      ),
    );
  }
}
