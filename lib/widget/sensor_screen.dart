import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class SensorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SensorScreenState();
}

class SensorScreenState extends State<SensorScreen> {
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer = _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope = _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor screen'),
      ),
      body: Column(
        children: <Widget>[
          new Padding(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Accelerometer: $accelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          new Padding(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('UserAccelerometer: $userAccelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          new Padding(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Gyroscope: $gyroscope'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
        ],
      ),
    );
  }
}
