import 'http_manager.dart';

class Api {
  ///基础Base
  static const String BASE_URL = "https://gank.io/api/v2";

  ///banner
  static const String URL_BANNER = "/banners";

  ///分类列表
  static const String URL_CATEGORY_LIST = "/data/category";

  static getGirlsList(int page) async {
    return await HttpManager.getInstance()
        .requestGet('$URL_CATEGORY_LIST/Girl/type/Girl/page/$page/count/20');
  }

  static getBanner() async {
    return await HttpManager.getInstance().requestGet(URL_BANNER);
  }

  static getCategoryList(int page, String category) async {
    return await HttpManager.getInstance().requestGet(
        '$URL_CATEGORY_LIST/GanHuo/type/$category/page/$page/count/20');
  }
}
