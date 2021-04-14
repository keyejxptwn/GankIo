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

  static getAndroidList(int page) async {
    return await HttpManager.getInstance().requestGet(
        '$URL_CATEGORY_LIST/GanHuo/type/Android/page/$page/count/20');
  }

  static getFlutterList(int page) async {
    return await HttpManager.getInstance().requestGet(
        '$URL_CATEGORY_LIST/GanHuo/type/Flutter/page/$page/count/20');
  }

  static getIOSList(int page) async {
    return await HttpManager.getInstance()
        .requestGet('$URL_CATEGORY_LIST/GanHuo/type/iOS/page/$page/count/20');
  }
}
