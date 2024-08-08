import 'package:flutter/material.dart';
import 'package:jalvidyut/screens/analytics/widgets/line_graph.dart';
import 'package:jalvidyut/utils/utils.dart';

import '../../../models/chart_data.dart';

class GraphViewer extends StatelessWidget {
  const GraphViewer({
    super.key,
    required this.isWater,
    required this.chartData,
    required this.weekIntervals,
    required this.totalConsumption,
    required this.previousData,
    required this.index,
    required this.leftButton,
    required this.rightButton,
  });

  final bool isWater;
  final List<List<ChartData>> chartData;
  final List<String> weekIntervals;
  final List<double> totalConsumption;
  final List<double> previousData;
  final int index;
  final VoidCallback leftButton;
  final VoidCallback rightButton;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: GestureDetector(
                  onTap: leftButton,
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 25,
                    color: Colors.black,
                  )),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  weekIntervals[index],
                  style: Utils.customHeadFontStyle(fontSize: 20),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  '${totalConsumption[index]} ${isWater ? 'kL' : 'kW'} consumed in this week',
                  style: Utils.customBodyFontStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                previousConsumptionAnalysis(index),

              ],
            ),

            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                  onTap: rightButton,
                  child: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 25,
                    color: Colors.black,
                  )),
            )
          ],
        ),

        const SizedBox(height: 20),

        LineGraph(
          isWater: isWater,
          chartData: chartData,
          index: index
        )
      ],
    );
  }

  Widget previousConsumptionAnalysis(int index) {
    if (index == 0) {
      return const SizedBox(height: 10);
    } else {
      double previousValue = previousData[index-1];
      if (previousValue < 0) {
        previousValue *= -1;
      }
      return Text(
        '${previousValue.toStringAsFixed(2)}% ${previousData[index-1]<0 ? 'less' : 'more'} than previous week',
        style: Utils.customTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

}
