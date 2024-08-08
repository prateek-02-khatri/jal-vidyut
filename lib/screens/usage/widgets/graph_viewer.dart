import 'package:flutter/material.dart';
import 'package:jalvidyut/screens/usage/widgets/column_graph.dart';

import '../../../models/chart_data.dart';
import '../../../utils/utils.dart';

class GraphViewer extends StatelessWidget {
  const GraphViewer({
    super.key,
    required this.isWater,
    required this.index,
    required this.chartData,
    required this.totalConsumption,
    required this.previousData,
    required this.dayIntervals,
    required this.leftButton,
    required this.rightButton,
  });

  final bool isWater;
  final int index;
  final List<List<ChartData>> chartData;
  final List<int> totalConsumption;
  final List<int> previousData;
  final List<String> dayIntervals;
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
                  '${totalConsumption[index]} ${isWater ? 'L' : 'U'} consumed on ${dayIntervals[index]}',
                  style: Utils.customBodyFontStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                index != 0
                    ?
                Text(
                  '${previousData[index-1].toString().replaceAll('-', '')} ${isWater ? 'L' : 'U'} ${previousData[index-1]<0 ? 'less' : 'more'} than ${dayIntervals[index-1]}',
                  style: Utils.customTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ) :
                const SizedBox(height: 10),
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

        ColumnGraph(
          isWater: isWater,
          chartData: chartData,
          index: index
        )

      ],
    );
  }
}
