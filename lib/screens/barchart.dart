import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

Widget sample8(BuildContext context) {
  final fromDate = DateTime.now().subtract(Duration(hours: 50));
  final toDate = DateTime.now();

  final date1 = toDate.subtract(Duration(hours: 2));
  final date2 = toDate.subtract(Duration(hours: 3));

  final date3 = toDate.subtract(Duration(hours: 10));
  final date4 = toDate.subtract(Duration(hours: 15));

  final date5 = toDate.subtract(Duration(hours: 19));
  final date6 = toDate.subtract(Duration(hours: 26));

  return Center(
    child: Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: BezierChart(
        bezierChartScale: BezierChartScale.HOURLY,
        fromDate: fromDate,
        toDate: toDate,
        selectedDate: toDate,
        series: [
          BezierLine(
            label: "Duty",
            data: [
              DataPoint<DateTime>(value: 0, xAxis: date1),
              DataPoint<DateTime>(value: 50, xAxis: date2),
              DataPoint<DateTime>(value: 100, xAxis: date3),
              DataPoint<DateTime>(value: 100, xAxis: date4),
              DataPoint<DateTime>(value: 40, xAxis: date5),
              DataPoint<DateTime>(value: 47, xAxis: date6),
            ],
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
          bubbleIndicatorTitleStyle: TextStyle(
            color: Colors.blue,
          ),
          bubbleIndicatorLabelStyle: TextStyle(
            color: Colors.red,
          ),
          displayYAxis: true,
          stepsYAxis: 25,
          backgroundGradient: LinearGradient(
            colors: [
              Colors.red[300],
              Colors.red[400],
              Colors.red[400],
              Colors.red[500],
              Colors.red,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          footerHeight: 35.0,
        ),
      ),
    ),
  );
}