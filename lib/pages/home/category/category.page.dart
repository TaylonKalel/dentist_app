import 'package:dentist_app/app.store.dart';
import 'package:dentist_app/datasources/models/category.model.dart';
import 'package:dentist_app/pages/home/category/category.store.dart';
import 'package:dentist_app/widget/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late final CategoryStore _store;
  late final AppStore _appStore;
  late final Future _getCategory;
  @override
  void initState() {
    super.initState();
    _appStore = GetIt.instance<AppStore>();
    _store = GetIt.instance<CategoryStore>();
    _getCategory = _store.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCategory,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 30),
              height: 30,
              padding: const EdgeInsets.only(left: 10),
              child: const TextWidget(
                text: "Categorias",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _store.categories.length,
                itemExtent: 50,
                itemBuilder: (BuildContext context, int index) {
                  return _itemCategory(_store.categories[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _itemCategory(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _appStore.setTabBarIndex(1);
        Navigator.of(context).pushNamed('/search', arguments: category.name);
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: TextWidget(
          text: category.name!,
          color: const Color(0xFF00B4CC),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
