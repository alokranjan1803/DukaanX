import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryProductsChart extends StatelessWidget {
  const CategoryProductsChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: SfCartesianChart()));
  }
}
