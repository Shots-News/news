import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/categories/categories_bloc.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/config.dart';
import 'package:news/constant/constant.dart';
import 'package:news/constant/dimensions.dart';
import 'package:news/locator.dart';
import 'package:news/models/category_model.dart';
import 'package:news/services/firebase_auth.dart';
import 'package:news/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({Key? key}) : super(key: key);

  @override
  _MyLibraryScreenState createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
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
        backgroundColor: MyColors.lightBlack,
        body: Container(
          width: MyDimensions.width(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// [Login]
                InkWell(
                  onTap: () {
                    locator<AuthService>().signInWIthGoogle();
                  },
                  child: Container(
                    height: 150,
                    width: MyDimensions.width(context),
                    color: MyColors.googleBlue,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Save Your Preferences',
                          style: style.h5BText(context)!.copyWith(color: MyColors.white),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                color: MyColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sign In',
                                    style: style.h6BText(context)!.copyWith(color: MyColors.lightBlack),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: MyColors.white,
                                ),
                                child: Image.asset('assets/images/google.png', width: 40),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// [Category]
                Container(
                  height: 150,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  _categoriesListBuilder(List<CategoryModel> _list) {
    return Container(
      child: ListView.builder(
        itemCount: _list.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 150,
            width: 120,
            margin: EdgeInsets.all(8),
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
          );
        },
      ),
    );
  }
}
