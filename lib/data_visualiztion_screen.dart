import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DataVisualizationScreen extends StatefulWidget {
  final List<String> selectedSensors;
  final String graphType;

  DataVisualizationScreen({required this.selectedSensors, required this.graphType});

  @override
  _DataVisualizationScreenState createState() => _DataVisualizationScreenState();
}

class _DataVisualizationScreenState extends State<DataVisualizationScreen> {
  List<FlSpot> _accelerometerData = [];
  List<FlSpot> _gyroscopeData = [];
  List<FlSpot> _magnetometerData = [];

  @override
  void initState() {
    super.initState();

    if (widget.selectedSensors.contains('Accelerometer')) {
      accelerometerEvents.listen((event) {
        setState(() {
          _accelerometerData.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), event.x));
        });
          print('Accelerometer: ${event.x}, ${event.y}, ${event.z}');
      });
    }

    if (widget.selectedSensors.contains('Gyroscope')) {
      gyroscopeEvents.listen((event) {
        setState(() {
          _gyroscopeData.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), event.x));
        });
         print('Gyroscope: ${event.x}, ${event.y}, ${event.z}');
      });
    }

    if (widget.selectedSensors.contains('Magnetometer')) {
      magnetometerEvents.listen((event) {
        setState(() {
          _magnetometerData.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), event.x));
        });
         print('Magnetometer: ${event.x}, ${event.y}, ${event.z}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Visualization')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: widget.graphType == 'line' ?
         LineChartWidget(
          accelerometerData: _accelerometerData,
          gyroscopeData: _gyroscopeData,
           magnetometerData: _magnetometerData,
        ) : BarChartWidget(
          accelerometerData: _accelerometerData,
          gyroscopeData: _gyroscopeData,
          magnetometerData: _magnetometerData,
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> accelerometerData;
  final List<FlSpot> gyroscopeData;
  final List<FlSpot> magnetometerData;
 LineChartWidget({
  Key? key,
    List<FlSpot>? accelerometerData,
    List<FlSpot> ?gyroscopeData,
    List<FlSpot> ? magnetometerData,
  })  : accelerometerData = accelerometerData ?? [],
        gyroscopeData = gyroscopeData ?? [],
        magnetometerData = magnetometerData ?? [],
        super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          if (accelerometerData.isNotEmpty)
            LineChartBarData(
              spots: accelerometerData,
              isCurved: true,
              colors: [Colors.blue],
            ),
          if (gyroscopeData.isNotEmpty)
            LineChartBarData(
              spots: gyroscopeData,
              isCurved: true,
              colors: [Colors.red],
            ),
          if (magnetometerData.isNotEmpty)
            LineChartBarData(
              spots: magnetometerData,
              isCurved: true,
              colors: [Colors.green],
            ),
        ],
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final List<FlSpot> accelerometerData;
  final List<FlSpot> gyroscopeData;
  final List<FlSpot> magnetometerData;

  BarChartWidget(
    {
     Key? key,
    List<FlSpot>? accelerometerData,
    List<FlSpot> ?gyroscopeData,
    List<FlSpot> ?magnetometerData,
  })  : accelerometerData = accelerometerData ?? [],
        gyroscopeData = gyroscopeData ?? [],
        magnetometerData = magnetometerData ?? [],
        super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData( alignment: BarChartAlignment.spaceAround,
        maxY: 10, 
        minY: -10, 
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
          ),
       //
          handleBuiltInTouches: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            margin: 16,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Acc';
                case 1:
                  return 'Gyro';
                case 2:
                  return 'Mag';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            margin: 16,
            reservedSize: 28,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        barGroups: [
           if (accelerometerData.isNotEmpty)
            BarChartGroupData(
              x: 0,
              barRods: accelerometerData.map((data) => BarChartRodData(y: data.y, colors: [Colors.blue])).toList(),
            ),
          if (gyroscopeData.isNotEmpty)
            BarChartGroupData(
              x: 1,
              barRods: gyroscopeData.map((data) => BarChartRodData(y: data.y, colors: [Colors.red])).toList(),
            ),
           if (magnetometerData.isNotEmpty)
            BarChartGroupData(
              x: 2,
              barRods: magnetometerData.map((data) => BarChartRodData(y: data.y, colors: [Colors.green])).toList(),
            ),
        ],
      ),
    );
  }
}
