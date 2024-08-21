abstract class FromJsonModel<T> {
  T fromJson(Map<String, dynamic> json);
  static Type typeOf<T>() => T;
}
