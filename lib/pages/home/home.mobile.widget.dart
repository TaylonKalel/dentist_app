// import 'package:dentist_app/app.store.dart';
import 'package:dentist_app/app.store.dart';
import 'package:dentist_app/pages/home/categories/category.page.dart';
import 'package:dentist_app/widget/tabbar.widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

class HomeMobileWidget extends StatefulWidget {
  const HomeMobileWidget({super.key});

  @override
  State<HomeMobileWidget> createState() => _HomeMobileWidgetState();
}

class _HomeMobileWidgetState extends State<HomeMobileWidget>
    with TickerProviderStateMixin {
  final AppStore _appStore = GetIt.instance();

  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
    return Column(
      children: [
        Flexible(
          child: Container(
            color: Colors.cyan,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .01,
                right: MediaQuery.of(context).size.width * .01,
                top: 40,
                bottom: 20),
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).pushNamed('/search');
                _tabController.animateTo(_appStore.tabBarIndex);
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
        ),
        const Gap(5),
      ],
    );
  }
}
