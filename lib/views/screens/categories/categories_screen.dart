import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:news/bloc/categories/categories_bloc.dart';
import 'package:news/constant/config.dart';
import 'package:news/constant/constant.dart';
import 'package:news/models/category_model.dart';
import 'package:news/views/screens/categories/categories_news_screen.dart';
import 'package:provider/provider.dart';

class MyCategoriesScreen extends StatefulWidget {
  const MyCategoriesScreen({Key? key}) : super(key: key);

  @override
  _MyCategoriesScreenState createState() => _MyCategoriesScreenState();
}

class _MyCategoriesScreenState extends State<MyCategoriesScreen> {
  @override
  void initState() {
    loadCategory();
    super.initState();
  }

  loadCategory() {
    context.read<CategoriesBloc>().add(CategoriesEvent.fetchCategories);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: style.h6BText(context),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (BuildContext context, CategoriesState state) {
              if (state is CategoriesError) {
                final error = state.error;
                String message = '${error.message}\nTap to Retry.';
                return Text(message);
              } else if (state is CategoriesLoaded) {
                List<CategoryModel> _list = state.categories;
                return _categoriesListBuilder(_list);
              } else if (state is CategoriesLoading) {
                List<CategoryModel> _list = state.categories!;
                return _categoriesListBuilder(_list);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  _categoriesListBuilder(List<CategoryModel> _list) {
    return GridView.builder(
      itemCount: _list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            FcNavigator().push(context, screen: MyCategoryNewsScreen());
          },
          child: Container(
            height: 150,
            width: 120,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Image.network(MyConfig.baseImageUrl + _list[index].image!),
                  ),
                  Text(
                    _list[index].name!,
                    style: style.bodyBText(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
