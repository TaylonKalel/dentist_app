// import 'package:dentist_app/app.store.dart';
import 'package:dentist_app/components/list_products.component.dart';
import 'package:dentist_app/components/loading.dart';
import 'package:dentist_app/components/models/list_products.component.dart';
import 'package:dentist_app/core/utils/is_same_day.dart';
import 'package:dentist_app/pages/home/category/category.page.dart';
import 'package:dentist_app/pages/home/home.store.dart';
import 'package:dentist_app/widget/tabbar.widget.dart';
import 'package:dentist_app/widget/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeMobileWidget extends StatefulWidget {
  const HomeMobileWidget({super.key});

  @override
  State<HomeMobileWidget> createState() => _HomeMobileWidgetState();
}

class _HomeMobileWidgetState extends State<HomeMobileWidget> {
  late final HomeStore _store;
  late final Future _future;

  @override
  void initState() {
    super.initState();
    _store = GetIt.instance<HomeStore>();
    _future = _store.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
        // tabController: _tabController,
        tabsBody: [
          _home(),
          const CategoryPage(),
          const Center(
            child: Text("Anunciar"),
          ),
          const Center(
            child: Text("Favoritos"),
          ),
          const Center(
            child: Text("Conta"),
          ),
        ]);
  }

  Widget _home() {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingComponent();
        }
        return Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .01,
                  right: MediaQuery.of(context).size.width * .01,
                  top: 40,
                  bottom: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/search');
                },
                child: TextFormField(
                  enabled: false,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Buscar",
                    filled: true,
                    focusColor: Colors.white,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      child: const TextWidget(
                        text: "Últimos anúnciados",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  Expanded(
                      child: Container(
                    child: _listProducts(),
                  ))
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _listProducts() {
    var today = DateTime.now();
    var yesterday = DateTime.now().subtract(const Duration(days: 1));
    return ListProductComponent(
      listProductsComponentModel: [
        ListProductsComponentModel(
            title: "Hoje",
            products: _store.producs
                .where((test) => isSameDay(test.dateAdded, today))
                .toList()),
        ListProductsComponentModel(
          title: "Ontem",
          products: _store.producs
              .where((test) => isSameDay(test.dateAdded, yesterday))
              .toList(),
        ),
        ListProductsComponentModel(
            title: "Mais antigos",
            products: _store.producs
                .where((test) =>
                    !isSameDay(test.dateAdded, yesterday) &&
                    !isSameDay(test.dateAdded, today))
                .toList()),
      ],
      onPressed: (p0) =>
          {Navigator.pushNamed(context, '/detail_product', arguments: p0)},
    );
  }
}
