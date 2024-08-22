import 'package:mobx/mobx.dart';

part 'loading.store.g.dart';

// ignore: library_private_types_in_public_api
class LoadingStore = _LoadingStore with _$LoadingStore;

abstract class _LoadingStore with Store {
  @observable
  bool isLoading = false;

  @action
  void active() {
    isLoading = true;
  }

  @action
  void deactive() {
    isLoading = false;
  }
}
