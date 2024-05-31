import 'package:aplikasibaru/prosesData/get_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DataFetch extends StatefulWidget {
  const DataFetch({Key? key});

  @override
  State<DataFetch> createState() => _DataFetchState();
}

class _DataFetchState extends State<DataFetch> {
  final List<double> waterLevel = [];
  final List<double> dataTime = [];
  double currentTime = 0.0;

  var data = [];
  @override
  void initState() {
    // TODO: implement initState
    getDataKetinggianAir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF33AAAA),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Permukaan Air",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Text(
            "Tinggi Muka Air",
            style: TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            child: FutureBuilder(
              future: getDataKetinggianAir(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var data = snapshot.data as List<Map<String, dynamic>>;
                  List<FlSpot> spots = data.asMap().entries.map((entry) {
                    int index = int.parse(entry.value["timestamp"]);
                    double distance = entry.value["distance"];
                    return FlSpot(index.toDouble(), distance);
                  }).toList();

                  print(spots);

                  return Center(
                    child: AspectRatio(
                      aspectRatio: 2.5 / 3, // Adjust aspect ratio here
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                              axisNameWidget: null,
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                              axisNameWidget: null,
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border:
                                Border.all(color: Color(0xff37434d), width: 1),
                          ),
                          minX: 0,
                          maxX: data.length.toDouble(),
                          minY: 0,
                          maxY: 3000,
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              color: Colors.red,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
