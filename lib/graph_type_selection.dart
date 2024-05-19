import 'package:flutter/material.dart';
import 'package:sensor_project/data_visualiztion_screen.dart';

class GraphTypeSelectionScreen extends StatelessWidget {
  final List<String> selectedSensors;

  GraphTypeSelectionScreen({required this.selectedSensors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Graph Type')),
      body: Column(
        children: [
          ListTile(
            title: Text('Line Graph'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataVisualizationScreen(
                    selectedSensors: selectedSensors,
                    graphType: 'line',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Bar Graph'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataVisualizationScreen(
                    selectedSensors: selectedSensors,
                    graphType: 'bar',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}