import 'package:flutter/material.dart';

class BasicGridView extends StatelessWidget {
  BasicGridView({super.key});

  final List<Map> products =
      List.generate(1000, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Gridview'),
      ),
      body: SafeArea(
          child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (context, index) {
          Map product = products[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.amber[200],
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(product['name']),
            ),
          );
        },
       
      )),
    );
  }
}
