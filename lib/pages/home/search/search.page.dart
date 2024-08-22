import 'package:dentist_app/components/loading.dart';
import 'package:dentist_app/components/product.component.dart';
import 'package:dentist_app/datasources/models/product.model.dart';
import 'package:dentist_app/pages/home/search/search.store.dart';
import 'package:dentist_app/widget/scaffold.widget.dart';
import 'package:dentist_app/widget/tabbar.widget.dart';
import 'package:dentist_app/widget/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

class SearchPage extends StatefulWidget {
  final String? search;
  const SearchPage({super.key, this.search});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchStore _store;
  late final Future _myFuture;
  late final bool _autofocus;

  @override
  void initState() {
    super.initState();
    _store = GetIt.instance<SearchStore>();

    _myFuture = _store.getRecentResearch();
    if (widget.search != null) {
      _store.clickOnRecentSearch(widget.search!).then((a) => {});
      _autofocus = false;
    } else {
      _autofocus = true;
    }
    // _store.getRecentResearch();
  }

  @override
  void dispose() {
    _store.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .01, vertical: 1),
          child: Observer(builder: (_) {
            return TextFormField(
              controller: _store.textSearchController,
              enabled: true,
              autofocus: _autofocus,
              focusNode: _store.focusNode,
              onChanged: _store.setSearching,
              onEditingComplete: () async {
                await _store.searchProducts();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                suffixIcon: _store.isEditing
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => _store.clearSearching(),
                      )
                    : null,
              ),
            );
          }),
        ),
        actions: [
          Observer(builder: (_) {
            if (_store.isEditing) {
              return Container(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * .05),
                child: InkWell(
                  child: const TextWidget(
                    text: "Filtros",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
              );
            }
            return Container();
          })
        ],
      ),
      body: FutureBuilder(
        future: _myFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: LoadingComponent());
          }
          return TabBarWidget(
            tabsBody: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Observer(builder: (_) {
                  return pageView();
                }),
              )
            ],
          );
        },
      ),
    );
  }

  Widget pageView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Visibility(
              visible: _store.filteredProducts.isNotEmpty,
              child: Positioned.fill(child: producsView())),
          Visibility(
              visible: _store.filteredProducts.isEmpty && _store.search != null,
              child: Positioned.fill(child: notFount())),
          Visibility(
              visible: _store.isVisibleRecentSearch,
              child: Positioned.fill(child: recentSearchView())),
          Visibility(
              visible: _store.loadingStore.isLoading,
              child: const Positioned.fill(child: LoadingComponent())),
        ],
      ),
    );
  }

  Widget recentSearchView() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: _store.filteredRecentResearch.length,
        itemExtent: 50,
        itemBuilder: (BuildContext context, int index) {
          return _itemList(_store.filteredRecentResearch[index]);
        },
      ),
    );
  }

  Widget producsView() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_store.filteredProducts.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              height: 50,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: TextWidget(
                text:
                    "${_store.filteredProducts.length} Resultados encontrados",
                fontWeight: FontWeight.w600,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _store.filteredProducts.length,
              itemExtent: 170,
              itemBuilder: (BuildContext context, int index) {
                return _itemProducts(_store.filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget notFount() {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(50),
        alignment: Alignment.center,
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/svg/not_fount.svg',
            ),
            const Gap(10),
            const TextWidget(
              text: "Resultado não encontrado",
              fontWeight: FontWeight.w600,
            ),
            const Gap(10),
            TextWidget(
              text:
                  'Não encontramos nenhum resultado parecido com "${_store.search}".',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemProducts(ProductModel product) {
    return ProductComponent(product: product);
  }

  Widget _itemList(String item) {
    return ListTile(
      onTap: () async => await _store.clickOnRecentSearch(item),
      leading: Icon(
        Icons.history,
        color: Colors.grey[500],
      ),
      title: TextWidget(text: item.toString(), color: Colors.grey[500]),
    );
  }
}
