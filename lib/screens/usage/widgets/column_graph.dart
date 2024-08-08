import 'package:flutter/material.dart';
import 'package:jalvidyut/models/chart_data.dart';
import 'package:jalvidyut/utils/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/utils.dart';

class ColumnGraph extends StatelessWidget {
  const ColumnGraph({
    super.key,
    required this.isWater,
    required this.chartData,
    required this.index
  });

  final bool isWater;
  final List<List<ChartData>> chartData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelStyle: Utils.customBodyFontStyle(
            fontSize: 14
          ),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          labelFormat: isWater ? '{value} L' : '{value} U',
          labelStyle: Utils.customBodyFontStyle(
              fontSize: 14
          ),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: isWater ? 'Water' : 'Electricity'
        ),
        series: <ColumnSeries<ChartData, String>>[
          ColumnSeries(
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataSource: chartData[index],
            color: isWater ? AppColors.waterColor : AppColors.electricityColor,
            animationDuration: 1000,
          )
        ],
      ),
    );
  }
}
