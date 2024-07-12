import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:dukaanx/features/admin/models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData;

  const CategoryProductsChart({super.key, required this.salesData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      series: <ColumnSeries<Sales, String>>[
        ColumnSeries<Sales, String>(
          dataSource: salesData,
          xValueMapper: (Sales sales, _) => sales.label,
          yValueMapper: (Sales sales, _) => sales.earning,
        )
      ],
    );
  }
}
