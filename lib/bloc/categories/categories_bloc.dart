import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/models/category_model.dart';
import 'package:news/repository/category_repo.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required this.categoriesRepository}) : super(CategoriesInitial());

  final CategoriesRepository categoriesRepository;
  late List<CategoryModel> categoriesList;

  List<CategoryModel>? _list = [];

  List<CategoryModel>? get data {
    return [..._list!];
  }

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    switch (event) {
      case CategoriesEvent.fetchCategories:
        yield CategoriesLoading(categories: _list);
        try {
          categoriesList = await categoriesRepository.getArticalsList();
          yield CategoriesLoaded(categories: categoriesList);
        } on SocketException {
          yield CategoriesError(error: 'No Internet');
        } on HttpException {
          yield CategoriesError(error: 'No Service');
        } on FormatException {
          yield CategoriesError(error: 'No Formate Exception');
        } catch (e) {
          print(e.toString());
          yield CategoriesError(error: 'Un Known Error ${e.toString()}');
        }
        break;
    }
  }
}