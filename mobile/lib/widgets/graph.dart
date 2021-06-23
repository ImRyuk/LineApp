import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line/blocs/affluence/affluence_bloc.dart';
import 'package:line/models/shop.dart';
import 'package:line/style/colors.dart';

class Graph extends StatelessWidget {
  final Shop shop;
  const Graph({required this.shop});

  List<BarChartGroupData> getHours(BuildContext context) {
    AffluenceState affState = context.watch<AffluenceBloc>().state;
    List<BarChartGroupData> data = [];
    if (affState is AffluenceLoaded) {
      affState.affluences.forEach((key, value) {
        data.add(
          BarChartGroupData(
            x: int.parse(key),
            barRods: [
              BarChartRodData(
                  y: double.parse(value["averageWait"].toString()), colors: [MyTheme.primaryColor])
            ],
          ),
        );
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  margin:2,
                  getTitles: (double value) {
                    return (value % 4 == 2) ? (value.round().toString() + "h") : "";
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: getHours(context)),
        ),
      ),
    );
  }
}
