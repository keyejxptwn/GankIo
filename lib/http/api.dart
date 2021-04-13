import 'http_manager.dart';

class Api {
  static const String base_url = "https://gank.io/api/v2";
  static const String url_banner = "/banners";
  static const String url_meizi_list = "/data/category/Girl/type/Girl/page/";

  static getMeiziList(int page) async {
    return await HttpManager.getInstance()
        .requestGet('$url_meizi_list$page/count/20');
  }

  static getBanner() async {
    return await HttpManager.getInstance().requestGet(url_banner);
  }
}
