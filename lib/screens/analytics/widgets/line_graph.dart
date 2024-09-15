import 'package:flutter/material.dart';
import 'package:jalvidyut/utils/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/chart_data.dart';
import '../../../utils/app_colors.dart';

class LineGraph extends StatelessWidget {
  const LineGraph({
    super.key,
    required this.isWater,
    required this.chartData,
    required this.index,
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
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          labelFormat: isWater ? '{value} L' :'{value} U',
          labelStyle: Utils.customBodyFontStyle(
            fontSize: 14
          ),
          maximum: 1000,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header:  isWater ? 'Water' :'Electricity'
        ),
        series: <LineSeries<ChartData, dynamic>>[
          LineSeries<ChartData, dynamic>(
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper:  (ChartData data, _) => data.y,
            dataSource: chartData[index],
            color: isWater ? AppColors.waterColor : AppColors.electricityColor,
            animationDuration: 1000,
            width: 2,
            markerSettings: const MarkerSettings(isVisible: true),
          )
        ],
      )
    );
  }
}
