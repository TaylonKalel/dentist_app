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

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchStore _store = SearchStore();
  late final Future _myFuture;

  @override
  void initState() {
    super.initState();
    _myFuture = _store.getRecentResearch();
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
              autofocus: true,
              focusNode: _store.focusNode,
              onChanged: _store.setSearching,
              onEditingComplete: () => _store.searchProducts,
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
              visible: _store.products.isNotEmpty,
              child: Positioned.fill(child: producsView())),
          Visibility(
              visible: _store.products.isEmpty && _store.search != null,
              child: Positioned.fill(child: notFount())),
          Visibility(
              visible: _store.isVisibleRecentSearch,
              child: Positioned.fill(child: recentSearchView())),
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
          if (_store.products.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              height: 50,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: TextWidget(
                text: "${_store.products.length} Resultados encontrados",
                fontWeight: FontWeight.w600,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _store.products.length,
              itemExtent: 170,
              itemBuilder: (BuildContext context, int index) {
                return _itemProducts(_store.products[index]);
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
      onTap: () => _store.clickOnRecentView(item),
      leading: Icon(
        Icons.history,
        color: Colors.grey[500],
      ),
      title: TextWidget(text: item.toString(), color: Colors.grey[500]),
    );
  }
}
