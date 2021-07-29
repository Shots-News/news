import 'package:flutter/cupertino.dart';
import 'package:news/constant/config.dart';
import 'package:news/models/category_model.dart';
import 'package:news/services/database.dart';
import 'package:api_cache_manager/api_cache_manager.dart';

class CategoryService with ChangeNotifier {
  CategoryService() {
    fetchCategory();
  }

  List<CategoryModel> _list = [];

  List<CategoryModel> get data {
    return [..._list];
  }

  fetchCategory() async {
    var isCacheExist = await APICacheManager().isAPICacheKeyExist(MyConfig.categoryTableName);

    if (isCacheExist) {
      var _data = await APICacheManager().getCacheData(MyConfig.categoryTableName) as CategoryModel;
      print("local $_data");
    } else {
      final res = await supabase.from(MyConfig.categoryTableName).select().execute();
      _list = res.data.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
      print(_list);
      notifyListeners();
      // APICacheDBModel _cacheDBModel = APICacheDBModel(
      //   key: MyConfig.categoryTableName,
      //   syncData: res.data.map<CategoryModel>((json) => CategoryModel.fromJson(json)),
      // );

      // await APICacheManager().addCacheData(_cacheDBModel);
    }
  }

  notifyListeners();
}
