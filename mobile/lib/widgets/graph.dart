import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:line/style/colors.dart';

class Graph extends StatelessWidget {
  const Graph();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barTouchData: BarTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => const TextStyle(
                      color: Color(0xff7589a2),
                      fontFamily: "Baloo",
                      fontSize: 12),
                  margin: 20,
                  getTitles: (double value) {
                    return (value % 4 == 2) ? 
                    (value.toString() + "h") : "" ;
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(y: 8, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(y: 10, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(y: 14, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(y: 15, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(y: 13, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 5,
                  barRods: [
                    BarChartRodData(y: 10, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 6,
                  barRods: [
                    BarChartRodData(y: 8, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 7,
                  barRods: [
                    BarChartRodData(y: 10, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 8,
                  barRods: [
                    BarChartRodData(y: 14, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 9,
                  barRods: [
                    BarChartRodData(y: 15, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 10,
                  barRods: [
                    BarChartRodData(y: 13, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 11,
                  barRods: [
                    BarChartRodData(y: 10, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 12,
                  barRods: [
                    BarChartRodData(y: 8, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 13,
                  barRods: [
                    BarChartRodData(y: 10, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 14,
                  barRods: [
                    BarChartRodData(y: 14, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 15,
                  barRods: [
                    BarChartRodData(y: 15, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 16,
                  barRods: [
                    BarChartRodData(y: 13, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 17,
                  barRods: [
                    BarChartRodData(y: 10, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 18,
                  barRods: [
                    BarChartRodData(y: 8, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 19,
                  barRods: [
                    BarChartRodData(y: 10, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 20,
                  barRods: [
                    BarChartRodData(y: 14, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 21,
                  barRods: [
                    BarChartRodData(y: 15, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 22,
                  barRods: [
                    BarChartRodData(y: 13, colors: [MyTheme.primaryColor])
                  ],
                ),
                BarChartGroupData(
                  x: 23,
                  barRods: [
                    BarChartRodData(y: 10, colors: [MyTheme.primaryColor])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
