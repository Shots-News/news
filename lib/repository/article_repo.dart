import 'package:flutter/cupertino.dart';
import 'package:news/constant/config.dart';
import 'package:news/models/article_model.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';

// abstract class ArticlesRepository {
//   Future<List<ArticleModel>> getArticlesList();
// }

class ArticleService with ChangeNotifier {
  ArticleService() {
    getArticlesList();
  }

  List<ArticleModel> _list = [];
  List<ArticleModel> get data {
    return [..._list];
  }

  // String getTableName(id) {
  //   return id == 0 ? MyConfig.articalTableName : MyConfig.articalTableName + "&category_id=eq.$id";
  // }

  Future<List<ArticleModel>> getArticlesList({int categoriesID = 2}) async {
    DioCacheManager _dioCacheManager;
    _dioCacheManager = DioCacheManager(
      CacheConfig(
        baseUrl: MyConfig.SUPABASE_URL + MyConfig.articalTableName,
        defaultRequestMethod: "GET",
        databaseName: "Articles",
      ),
    );
    Options _cacheOptions = buildCacheOptions(
      Duration(days: 7),
      forceRefresh: true,
      options: Options(
        method: "GET",
        headers: {
          "Authorization": "Bearer ${MyConfig.SUPABASE_API}",
          "apikey": MyConfig.SUPABASE_API,
        },
      ),
    );
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      Response response = await _dio.get(
        MyConfig.SUPABASE_URL + MyConfig.articalTableName,
        options: _cacheOptions,
      );
      _list = response.data.map<ArticleModel>((json) => ArticleModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
    }

    notifyListeners();
    return data;
  }
}
