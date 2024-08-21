import 'package:dentist_app/widget/text.widget.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var list = List.generate(10, (index) {
      return "Teste $index";
    });
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 30),
          height: 30,
          padding: const EdgeInsets.only(left: 10),
          child: const TextWidget(
            text: "Categorias",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemExtent: 50,
            itemBuilder: (BuildContext context, int index) {
              return _itemCategory(list[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _itemCategory(String list) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: TextWidget(
        text: list,
        color: const Color(0xFF00B4CC),
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
