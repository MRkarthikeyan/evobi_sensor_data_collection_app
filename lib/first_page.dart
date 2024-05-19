import 'package:flutter/material.dart';
import 'package:sensor_project/graph_type_selection.dart';

class sensorselectionscreen extends StatefulWidget {
  const sensorselectionscreen({super.key});

  @override
  State<sensorselectionscreen> createState() => _sensorselectionscreenState();
}

class _sensorselectionscreenState extends State<sensorselectionscreen> {
   List<String> sensors = ['Accelerometer', 'Gyroscope', 'Magnetometer'];
  List<String> selectedSensors = [];

  void _onSensorSelected(bool selected, String sensorName) {
    setState(() {
      if (selected) {
        selectedSensors.add(sensorName);
      } else {
        selectedSensors.remove(sensorName);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Select Sensors')),
      body: 
      ListView(
        children: sensors.map((sensor) {
          return CheckboxListTile(
            title: Text(sensor),
            value: selectedSensors.contains(sensor),
            onChanged: (bool? selected) {
              _onSensorSelected(selected!, sensor);
            },
          );
        })
        .toList(),
      ),
      floatingActionButton: 
    
      Center(
        child: TextButton(onPressed:  selectedSensors.length >= 2
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GraphTypeSelectionScreen(
                        selectedSensors: selectedSensors,
                      ),
                    ),
                  );
                }
              : null,
        child: Text('NEXT',)),
      ),
    );
  }
}
