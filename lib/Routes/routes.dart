import 'package:get/get.dart';
import 'package:news/View/home.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RouteName.home,
            page: () => const Home(),
            transition: Transition.leftToRight),
        // GetPage(
        //     name: RouteName.newsDetails,
        //     page: () =>  NewsDetails(index: index,),
        //     transition: Transition.leftToRight),
      ];
}
