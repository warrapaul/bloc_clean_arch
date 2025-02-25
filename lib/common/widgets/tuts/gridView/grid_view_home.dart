import 'package:bloc_clean_arch/common/widgets/tuts/gridView/basic_grid_view.dart';
import 'package:flutter/material.dart';

/*
*
 - GridView.count - a layout with fixed number of tiles in the cross axis
 - GridView.extent - create tiles that have a maximum cross-axis extent
 - SilverGridDelegate - produce arbitrary 2D arrangement of children that are
      unaligned or overlapping
 - GridView.builder - grid with large/ inifinite children

************* builder
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
############ MAKE THE APPBAR SCROLLABLE
- wrap the GridView.builder in a CustomScrollView and use SliverAppbar instead of regular AppBar



 ********************count
 child: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        crossAxisSpacing: 10,
        mainAxisSpacing: 2,
        children: [
 */

class GridViewHome extends StatelessWidget {
  const GridViewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BasicGridView()));
                },
                child: const Text('basic grid'))
          ],
        ),
      ),
    );
  }
}
