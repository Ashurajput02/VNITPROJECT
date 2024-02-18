// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatefulWidget {
  final List<int> chartData;

  Chart({Key? key, required this.chartData}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [Color(0xFF003366), Color(0xFF006699)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: LineChart(
            LineChartData(
              minX: 0,
              minY: 0,
              maxX: 60,
              maxY: 100,
              backgroundColor: Color.fromARGB(125, 0, 0, 0),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameWidget: Text(
                    "Length(mm)",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                  axisNameSize: 18,
                ),
                bottomTitles: AxisTitles(
                  axisNameSize: 16,
                  axisNameWidget: Text(
                    "Time(sec)",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Color.fromARGB(0, 0, 24, 89),
                  width: 1,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: widget.chartData
                      .asMap()
                      .entries
                      .map((entry) =>
                          FlSpot(entry.key.toDouble(), entry.value.toDouble()))
                      .toList(),
                  isCurved: true,
                  color: Color.fromARGB(255, 228, 224, 0),
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                  shadow: BoxShadow(
                    color: Color.fromARGB(255, 248, 255, 31).withOpacity(0.4),
                    blurRadius: 8.0,
                    spreadRadius: 4.0,
                  ),
                ),
              ],
            ),
            swapAnimationCurve: Curves.linear,
            swapAnimationDuration: Duration(milliseconds: 500),
          ),
        ),
      ),
    );
  }
}
