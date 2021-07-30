import 'package:flutter/cupertino.dart';
import 'package:news/constant/config.dart';
import 'package:news/models/category_model.dart';
import 'package:news/services/database.dart';

abstract class CategoriesRepository {
  Future<List<CategoryModel>> getArticalsList();
}

class CategoryService with ChangeNotifier implements CategoriesRepository {
  CategoryService() {
    getArticalsList();
  }

  List<CategoryModel> _list = [];

  List<CategoryModel> get data {
    return [..._list];
  }

  @override
  Future<List<CategoryModel>> getArticalsList() async {
    final res = await supabase.from(MyConfig.categoryTableName).select().execute();
    _list = res.data.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
    print(_list);
    notifyListeners();
    return data;
  }
}
