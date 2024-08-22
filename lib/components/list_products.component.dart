import 'package:dentist_app/components/models/list_products.component.dart';
import 'package:dentist_app/components/product.component.dart';
import 'package:dentist_app/datasources/models/product.model.dart';
import 'package:dentist_app/widget/text.widget.dart';
import 'package:flutter/material.dart';

class ListProductComponent extends StatefulWidget {
  final List<ListProductsComponentModel> listProductsComponentModel;
  final Function(ProductModel)? onPressed;
  const ListProductComponent({
    super.key,
    required this.listProductsComponentModel,
    this.onPressed,
  });

  @override
  State<ListProductComponent> createState() => _ListProductComponentState();
}

class _ListProductComponentState extends State<ListProductComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listProductsComponentModel.length,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return _itemList(widget.listProductsComponentModel[index]);
      },
    );
  }

  Widget _itemList(ListProductsComponentModel listProductsComponentModel) {
    if (listProductsComponentModel.products.isEmpty) return Container();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _title(listProductsComponentModel),
          ...listProductsComponentModel.products
              .map((toElement) => GestureDetector(
                    onTap: () => {
                      if (widget.onPressed != null)
                        {widget.onPressed!(toElement)}
                    },
                    child: SizedBox(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      child: ProductComponent(product: toElement),
                    ),
                  ))
        ],
      ),
    );
  }

  Container _title(ListProductsComponentModel listProductsComponentModel) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.surface,
        child: TextWidget(
          text: listProductsComponentModel.title,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey[500],
        ));
  }
}
