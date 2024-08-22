import 'package:dentist_app/app.store.dart';
import 'package:dentist_app/widget/scaffold.widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class TabBarWidget extends StatefulWidget {
  final List<Widget> tabsBody;
  const TabBarWidget({super.key, required this.tabsBody});

  @override
  // ignore: library_private_types_in_public_api
  TabBarWidgetState createState() => TabBarWidgetState();
}

class TabBarWidgetState extends State<TabBarWidget>
    with TickerProviderStateMixin {
  // @override
  final AppStore _store = GetIt.instance();

  late final TabController _tabController;
  late final List<Widget> _bodies;

  void setIndex(int index) {
    if (kDebugMode) {
      print('#COD CHAMOU O TABBAR');
    }
    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    _bodies = widget.tabsBody;
    while (_bodies.length < 5) {
      _bodies.add(Container());
    }
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      _clickTabl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_store.tabBarIndex != _tabController.index) {
        setIndex(_store.tabBarIndex);
      }
      return ScaffoldWidget(
        body: TabBarView(
          controller: _tabController,
          children: _bodies,
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: Colors.transparent,
          tabs: const <Widget>[
            Tab(
              text: "Home",
              icon: Icon(Icons.home),
            ),
            Tab(
              text: "Categorias",
              icon: Icon(Icons.category),
            ),
            Tab(
              text: "Anunciar",
              icon: Icon(Icons.add_circle_outline_rounded),
            ),
            Tab(
              text: "Favoritos",
              icon: Icon(Icons.favorite_border),
            ),
            Tab(
              text: "Conta",
              icon: Icon(Icons.person_outline),
            ),
          ],
        ),
      );
    });
  }

  _clickTabl() {
    String? routeName = ModalRoute.of(context)?.settings.name;
    if (routeName != null) {
      if (routeName != "/") {
        Navigator.popUntil(context, (routes) => routes.settings.name == "/");
      }
    }
    _store.setTabBarIndex(_tabController.index);
  }
}
