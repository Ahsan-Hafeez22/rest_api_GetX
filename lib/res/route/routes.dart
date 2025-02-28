import 'package:get/get.dart';
import 'package:rest_api_project/res/route/route_names.dart';
import 'package:rest_api_project/view/app_selection_screen.dart';
import 'package:rest_api_project/view/dictionary_api/home_dictionary_view.dart';
import 'package:rest_api_project/view/e_commerce_api/home_ecommerce_page.dart';
import 'package:rest_api_project/view/news_api/category_view.dart';
import 'package:rest_api_project/view/news_api/home_news_page.dart';
import 'package:rest_api_project/view/news_api/new_view.dart';
import 'package:rest_api_project/view/splash_screen.dart';
import 'package:rest_api_project/view/weather_api/home_weather_view.dart';

class AppRoutes {
  static List<GetPage> appRoutes() {
    return [
      GetPage(
        name: RoutesName.splashScreen,
        page: () => SplashScreen(),
        transition: Transition.fadeIn,
      ),
      //ecommerce routes here...
      GetPage(
        name: RoutesName.homeEcommercePage,
        page: () => HomeEcommercePage(),
        transition: Transition.rightToLeft,
      ),

      //news app routes here...
      GetPage(
        name: RoutesName.homeNewsPage,
        page: () => HomeNewsPage(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutesName.categoryViewPage,
        page: () => CategoryView(
          category: "",
        ),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutesName.newsDetailPage,
        page: () => NewsDetailPage(
          content: "",
          description: "",
          imageUrl: "",
          publishAt: "",
          source: "",
          title: "",
        ),
        transition: Transition.rightToLeft,
      ),

      //dictionary app routes here...
      GetPage(
        name: RoutesName.homeDictionaryPage,
        page: () => HomeDictionaryPage(),
        transition: Transition.rightToLeft,
      ),
      //app selection screen here...
      GetPage(
        name: RoutesName.appSelectionScreen,
        page: () => AppSelectionScreen(),
        transition: Transition.rightToLeft,
      ),
      //Weather app
      GetPage(
        name: RoutesName.homeWeatherPage,
        page: () => HomeWeatherView(),
        transition: Transition.rightToLeft,
      ),
    ];
  }
}
