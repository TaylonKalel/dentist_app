import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentist_app/core/utils/is_same_day.dart';
import 'package:dentist_app/datasources/models/product.model.dart';
import 'package:dentist_app/core/utils/formatters/currency.formatter.dart';
import 'package:dentist_app/widget/badge.widget.dart';
import 'package:dentist_app/widget/button.widget.dart';
import 'package:dentist_app/widget/scaffold.widget.dart';
import 'package:dentist_app/widget/tabbar.widget.dart';
import 'package:dentist_app/widget/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final ProductModel product;

  @override
  void initState() {
    super.initState();

    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
      tabsBody: [_body()],
    );
  }

  Widget _body() {
    return SafeArea(
      
      child: ScaffoldWidget(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.image != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Scaffold(
                              extendBody: true,
                              body: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Center(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: product.image!,
                                  ),
                                ),
                              ));
                        }))
                      },
                      child: CachedNetworkImage(
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: product.image!,
                      ),
                    ),
                  ),
                ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      child: BadgeWidget(
                          color: Colors.cyan[700], text: product.category!)),
                  if (product.isNew == true)
                    Container(
                        alignment: Alignment.centerRight,
                        child:
                            BadgeWidget(color: Colors.cyan[200], text: "Novo")),
                ],
              ),
              const Gap(16),
              TextWidget(
                text: product.title ?? 'Sem Título',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Gap(8),
              TextWidget(
                text: product.description ?? 'Sem Descrição',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
              const Gap(16),
              if (product.discount != null)
                BadgeWidget(
                  text: "${product.discount}% OFF",
                  color: Colors.cyan[200],
                  colorText: Colors.cyan[900],
                ),
              const Gap(16),
              TextWidget(
                text:
                    'Preço: ${CurrencyPtBrInputFormatter.currencyFormatter(product.discount != null ? product.price : product.newPrice)}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  decoration: product.discount != null
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              if (product.discount != null)
                TextWidget(
                  text:
                      'Preço com Desconto: ${CurrencyPtBrInputFormatter.currencyFormatter(product.newPrice)}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Gap(16),
              if (product.maxInstallments != null)
                TextWidget(
                  text:
                      'Em até: ${product.maxInstallments}x de ${CurrencyPtBrInputFormatter.currencyFormatter(product.monthlyValue)}',
                  style: const TextStyle(fontSize: 16),
                ),
              const Gap(16),
              _textDateAdd(),
              const Gap(24),
              Center(
                  child: ButtonWidget(
                onPressed: () {},
                color: Colors.cyan[900],
                child: const TextWidget(
                  text: 'Comprar Agora',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textDateAdd() {
    var dateFormat = DateFormat.yMd();
    Widget widReturn = TextWidget(
      text:
          'Adicionado em: ${product.dateAdded != null ? dateFormat.format(product.dateAdded!) : 'N/A'}',
      style: const TextStyle(fontSize: 14),
    );
    if (isSameDay(product.dateAdded, DateTime.now())) {
      widReturn = const TextWidget(
        text: 'Adicionado hoje',
        style: TextStyle(fontSize: 14),
      );
    } else if (isSameDay(
        product.dateAdded, DateTime.now().subtract(const Duration(days: 1)))) {
      widReturn = const TextWidget(
        text: 'Adicionado ontem',
        style: TextStyle(fontSize: 14),
      );
    }
    return widReturn;
  }
}
