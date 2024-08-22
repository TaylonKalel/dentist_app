import 'package:dentist_app/datasources/models/product.model.dart';
import 'package:dentist_app/datasources/repositories/product.repository.dart';
import 'package:dentist_app/datasources/repositories/recent_search.repository.dart';
import 'package:dentist_app/datasources/models/recent_search.model.dart';
import 'package:dentist_app/loading.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:mobx/mobx.dart';

part 'search.store.g.dart';

// ignore: library_private_types_in_public_api
class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  late final RecentSearchRepository _recentSearchRepository;
  late final ProductRepository _productRepository;

  final LoadingStore loadingStore = GetIt.I();

  _SearchStore() {
    _recentSearchRepository = GetIt.instance<RecentSearchRepository>();
    _productRepository = GetIt.instance<ProductRepository>();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setIsVisibleRecentSearch(true);
      } else {
        setIsVisibleRecentSearch(false);
      }
    });
  }

  // List<ProductModel> products = [];
  @observable
  List<String> recentResearch = [];
  @observable
  List<String> filteredRecentResearch = [];
  @observable
  ObservableList<ProductModel> filteredProducts = ObservableList();
  @observable
  TextEditingController textSearchController = TextEditingController();
  @observable
  FocusNode focusNode = FocusNode();
  @observable
  bool isVisibleRecentSearch = false;
  @observable
  String? search;

  @computed
  bool get isEditing {
    if (search != null && search!.length > 1) {
      return true;
    }
    return false;
  }

  Future getRecentResearch() async {
    var result = await _recentSearchRepository.getRecentSearchs();
    RecentSearchModel recentSearch = RecentSearchModel();
    if (result.item != null) {
      recentSearch = result.item!;
    }
    setRecentResearch(recentSearch.list);
  }

  @action
  Future clickOnRecentSearch(String value) async {
    search = value;
    textSearchController.text = value;
    await searchProducts();
  }

  @action
  void setIsVisibleRecentSearch(bool value) => isVisibleRecentSearch = value;

  @action
  void setRecentResearch(List<String> values) {
    recentResearch.clear();
    filteredRecentResearch.clear();
    recentResearch.addAll(values);
    filteredRecentResearch.addAll(values);
  }

  @action
  void addSearch(String value) {
    recentResearch.insert(0, value);
  }

  @action
  void filterRecentResearch(String? value) {
    filteredRecentResearch.clear();
    if (value == null) {
      filteredRecentResearch.addAll(recentResearch);
      return;
    }
    filteredRecentResearch.addAll(recentResearch
        .where((tex) => tex.toLowerCase().contains(value.toLowerCase()))
        .toList());
  }

  @action
  void setSearching(String? value) {
    search = value;
    filterRecentResearch(value);
  }

  @action
  void clearSearching() {
    setSearching(null);
    textSearchController.clear();
    focusNode.requestFocus();
  }

  @action
  Future searchProducts() async {
    if (search == null) return;
    addSearch(search!);
    loadingStore.active();
    focusNode.unfocus();
    await Future.delayed(const Duration(seconds: 2));
    var resultSearch = await _productRepository.getProductsBySearch(search!);
    filteredProducts.addAll(resultSearch.list ?? []);
    loadingStore.deactive();
  }

  void disposed() {
    textSearchController.dispose();
    focusNode.dispose();
  }
}
