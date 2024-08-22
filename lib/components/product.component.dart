import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentist_app/components/loading.dart';
import 'package:dentist_app/core/utils/formatters/currency.formatter.dart';
import 'package:dentist_app/datasources/models/product.model.dart';
import 'package:dentist_app/widget/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductComponent extends StatelessWidget {
  final ProductModel product;

  const ProductComponent({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          {Navigator.pushNamed(context, '/detail_product', arguments: product)},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey.withOpacity(0.2)),
                bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  placeholder: (context, url) => const LoadingComponent(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (product.discount != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextWidget(
                          text: "${product.discount}% OFF",
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    TextWidget(
                      text: product.title!,
                      maxLines: 2,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    if (product.discount == null) _priceText(),
                    if (product.discount != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: CurrencyPtBrInputFormatter.currencyFormatter(
                                product.price),
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[400],
                          ),
                          _priceText()
                        ],
                      ),
                    if (product.monthlyValue != null)
                      TextWidget(
                        text:
                            "Em até ${product.maxInstallments}x de R\$ ${CurrencyPtBrInputFormatter.currencyFormatter(product.monthlyValue)}",
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                      ),
                    if (product.isNew == true)
                      TextWidget(
                        text: "Novo",
                        color: Colors.grey[500],
                        fontSize: 16,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceText() {
    return TextWidget(
      text: CurrencyPtBrInputFormatter.currencyFormatter(product.newPrice),
      maxLines: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
