import 'package:flutter/cupertino.dart';
import 'package:news/constant/config.dart';
import 'package:news/models/category_model.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';

abstract class CategoriesRepository {
  Future<List<CategoryModel>> getCategoriesList();
}

class CategoryService with ChangeNotifier implements CategoriesRepository {
  CategoryService() {
    getCategoriesList();
  }

  List<CategoryModel> _list = [];
  List<CategoryModel> get data => [..._list];

  @override
  Future<List<CategoryModel>> getCategoriesList() async {
    print(MyConfig.SUPABASE_URL + MyConfig.categoryTableName);
    DioCacheManager _dioCacheManager;
    _dioCacheManager = DioCacheManager(
      CacheConfig(
        baseUrl: MyConfig.SUPABASE_URL + MyConfig.categoryTableName,
        defaultRequestMethod: "GET",
        databaseName: "Categories",
      ),
    );
    Options _cacheOptions = buildCacheOptions(
      Duration(days: 7),
      forceRefresh: true,
      options: Options(
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
        MyConfig.SUPABASE_URL + MyConfig.categoryTableName,
        options: _cacheOptions,
      );
      _list = response.data.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
    }

    notifyListeners();
    return data;
  }
}
