import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takhleekish/Artist/throughNavbar/AnalyticsPage/barGraph/barData.dart';

class BarGraph extends StatefulWidget {
  final double AbstractAmount;
  final double landscapeAmount;
  final double portraitAmount;
  final double StillLifeAmount;
  final double ModernArtAmount;
  final double ContemporaryAmount;

  BarGraph({
    required this.AbstractAmount,
    required this.landscapeAmount,
    required this.portraitAmount,
    required this.StillLifeAmount,
    required this.ModernArtAmount,
    required this.ContemporaryAmount,
  });

  @override
  _BarGraphState createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late BarData barData;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust duration as needed
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color mainBarColor = Color(0xFF2196F3);
    Color backgroundBarColor = Color(0xFFE0E0E0);
    Color gridLinesColor = Color(0xFFBDBDBD);
    Color textColor = Colors.white;
    barData = BarData(
      AbstractAmount: widget.AbstractAmount,
      landscapeAmount: widget.landscapeAmount,
      portraitAmount: widget.portraitAmount,
      StillLifeAmount: widget.StillLifeAmount,
      ModernArtAmount: widget.ModernArtAmount,
      ContemporaryAmount: widget.ContemporaryAmount,
    );


    barData.intializeBarData();

    Color abstractColor = Color(0xFF2196F3);
    Color landscapeColor = Color(0xFF93291E);
    Color portraitColor = Color(0xFF005AA7);
    Color stillLifeColor = Color(0xFF667db6);
    Color modernArtColor = Color(0xFF355C7D);
    Color contemporaryColor = Color(0xFF23074d);


    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Card(
          elevation: 6,
          color: Color(0xffcbb4d4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                maxY: 20,
                minY: 0,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: barData.barData.map((data) {
                  double height = data.y * _animationController.value;
                  Color barColor;
                  switch (data.x) {
                    case 0:
                      barColor = abstractColor;
                      break;
                    case 1:
                      barColor = landscapeColor;
                      break;
                    case 2:
                      barColor = portraitColor;
                      break;
                    case 3:
                      barColor = stillLifeColor;
                      break;
                    case 4:
                      barColor = modernArtColor;
                      break;
                    case 5:
                      barColor = contemporaryColor;
                      break;
                    default:
                      barColor = Colors.grey;
                      break;
                  }
                  return BarChartGroupData(
                    x: data.x,
                    barRods: [
                      BarChartRodData(
                        toY: height,
                        color: barColor,
                        width: 13,
                        borderRadius: BorderRadius.circular(4),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 20,
                          color: Colors.grey[300],
                        ),
                      )
                    ],
                  );
                }).toList(),

                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),


                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getBottomTiles,
                    ),
                  ),
                  // Set left titles to white


                ),
              ),
            ),
          ),
        );
      },

    );
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10, fontWeight: FontWeight.bold,);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          "Abst",
          style: style,
        );
        break;
      case 1:
        text = const Text(
          "Lands",
          style: style,
        );
        break;
      case 2:
        text = const Text(
          "Port",
          style: style,
        );
        break;
      case 3:
        text = const Text(
          "Still",
          style: style,
        );
        break;
      case 4:
        text = const Text(
          "Modern",
          style: style,
        );
        break;
      case 5:
        text = const Text(
          "Contemp",
          style: style,
        );
        break;
      default:
        text = const Text(
          "",
          style: style,
        );
        break;
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}
