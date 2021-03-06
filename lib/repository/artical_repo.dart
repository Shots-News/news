import 'package:flutter/cupertino.dart';
import 'package:news/constant/config.dart';
import 'package:news/models/artical_model.dart';
import 'package:news/services/database.dart';

abstract class ArticalsRepository {
  Future<List<ArticalModel>> getArticalsList();
}

class ArticalService with ChangeNotifier implements ArticalsRepository {
  ArticalService() {
    getArticalsList();
  }

  List<ArticalModel> _list = [];

  List<ArticalModel> get data {
    return [..._list];
  }

  @override
  Future<List<ArticalModel>> getArticalsList() async {
    final res = await supabase
        .from(MyConfig.articalTableName)
        .select()
        .eq('draft', false)
        .order('updated_at', ascending: false)
        .execute();
    _list = res.data.map<ArticalModel>((json) => ArticalModel.fromJson(json)).toList();
    notifyListeners();
    return data;
  }
}
