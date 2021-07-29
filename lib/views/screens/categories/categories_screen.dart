import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/config.dart';
import 'package:news/constant/constant.dart';
import 'package:news/repository/category_repo.dart';
import 'package:news/views/screens/categories/categories_page_view.dart';
import 'package:provider/provider.dart';

class MyCategoriesScreen extends StatefulWidget {
  const MyCategoriesScreen({Key? key}) : super(key: key);

  @override
  _MyCategoriesScreenState createState() => _MyCategoriesScreenState();
}

class _MyCategoriesScreenState extends State<MyCategoriesScreen> {
  @override
  void initState() {
    final categories = Provider.of<CategoryService>(context, listen: false);
    categories.fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryService>(context);

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
          child: categories.data.length == 0
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  itemCount: categories.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Card(
                        color: MyColors.lightBlack,
                        child: InkWell(
                          onTap: () {
                            FcNavigator().push(context, screen: MyCategoryPageView());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                MyConfig.baseImageUrl + categories.data[index].image!,
                                width: 120,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                categories.data[index].name!,
                                style: style.h6BText(context),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
