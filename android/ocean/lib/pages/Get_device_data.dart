import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeviceDetailsPage extends StatefulWidget {
  final String token;

  const DeviceDetailsPage({Key? key, required this.token}) : super(key: key);

  @override
  _DeviceDetailsPageState createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  late bool _isToggled; // Indicates whether the toggle is on or off

  // Sample data for the line graphs
  List<double> _temperatureData = [];
  List<double> _noiseData = [];
  List<double> _salinityData = [];
  List<double> _murkinessData = [];

  double _latestTemperature = 0.0;
  double _latestNoise = 0.0;
  double _latestSalinity = 0.0;
  double _latestMurkiness = 0.0;

  @override
  void initState() {
    super.initState();
    _isToggled = false; // Initially, toggle is off
    fetchData(); // Fetch initial data
    fetchLastData();
  }

  // Method to fetch data from the server
  void fetchLastData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.166.172:8000/api/device/1'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> dataList = jsonDecode(response.body);

        if (dataList.isNotEmpty) {
          List<double> temperatures = dataList
              .map<double>((data) {
            final temperature = data['temperature'];
            return temperature != null ? temperature.toDouble() : 0.0;
          }) // handle null temperature values
              .toList()
              .reversed
              .take(10)
              .toList();

          List<double> noises = dataList
              .map<double>((data) {
            final noise = data['noise'];
            return noise != null ? noise.toDouble() : 0.0;
          }) // handle null noise values
              .toList()
              .reversed
              .take(10)
              .toList();

          List<double> salinities = dataList
              .map<double>((data) {
            final salinity = data['salinity'];
            return salinity != null ? salinity.toDouble() : 0.0;
          }) // handle null salinity values
              .toList()
              .reversed
              .take(10)
              .toList();

          List<double> murkiness = dataList
              .map<double>((data) {
            final murkiness = data['murkiness'];
            return murkiness != null ? murkiness.toDouble() : 0.0;
          }) // handle null murkiness values
              .toList()
              .reversed
              .take(10)
              .toList();

          setState(() {
            _temperatureData = temperatures;
            _noiseData = noises;
            _salinityData = salinities;
            _murkinessData = murkiness;
          });
        } else {
          print('No data available');
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.166.172:8000/api/device/1'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> dataList = jsonDecode(response.body);

        if (dataList.isNotEmpty) {
          // Get the latest readings
          var latestData = dataList.last;

          setState(() {
            _latestTemperature = latestData['temperature'] != null ? latestData['temperature'].toDouble() : 0.0;
            _latestNoise = latestData['noise'] != null ? latestData['noise'].toDouble() : 0.0;
            _latestSalinity = latestData['salinity'] != null ? latestData['salinity'].toDouble() : 0.0;
            _latestMurkiness = latestData['murkiness'] != null ? latestData['murkiness'].toDouble() : 0.0;
          });
        } else {
          print('No data available');
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Station_1"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Toggle to switch views'), // Text on the left
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isToggled = !_isToggled; // Toggle the state
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: 50, // Width of the toggle button
                    height: 30, // Height of the toggle button
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), // Oval shape
                      color: _isToggled ? Color(0xFF65C466) : Color(0xFFE9E9EB), // Color based on toggle state
                    ),
                    child: Stack(
                      alignment: _isToggled ? Alignment.centerRight : Alignment.centerLeft,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: 26, // Diameter of the circle
                          height: 26, // Diameter of the circle
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isToggled ? Color(0xFF65C466) : Color(0xFFE9E9EB), // Circle background color (synced with toggle button background)
                          ),
                        ),
                        Positioned(
                          left: _isToggled ? 22.0 : 2.0,
                          child: Container(
                            width: 26.0,
                            height: 26.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // Circle color (always black)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Add views based on toggle state
            Visibility(
              visible: !_isToggled, // Show this view when toggle is off
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0)
                    ),
                    Text("Temperature"),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: _temperatureData.isNotEmpty
                          ? LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: _temperatureData.asMap().entries.map((entry) {
                                return FlSpot(entry.key.toDouble(), entry.value);
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                          : Center(
                        child: Text(
                          'No temperature data available',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Salinity"),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: _salinityData.isNotEmpty
                          ? LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: _salinityData.asMap().entries.map((entry) {
                                return FlSpot(entry.key.toDouble(), entry.value);
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                          : Center(
                        child: Text(
                          'No salinity data available',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Noise"),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: _noiseData.isNotEmpty
                          ? LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: _noiseData.asMap().entries.map((entry) {
                                return FlSpot(entry.key.toDouble(), entry.value);
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                          : Center(
                        child: Text(
                          'No noise data available',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Murkiness"),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: _murkinessData.isNotEmpty
                          ? LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: _murkinessData.asMap().entries.map((entry) {
                                return FlSpot(entry.key.toDouble(), entry.value);
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                          : Center(
                        child: Text(
                          'No murkiness data available',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _isToggled, // Show this view when toggle is on
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  // Display latest readings for each data element
                  ListTile(
                    title: Text('Temperature: $_latestTemperature'),
                  ),
                  ListTile(
                    title: Text('Noise: $_latestNoise'),
                  ),
                  ListTile(
                    title: Text('Salinity: $_latestSalinity'),
                  ),
                  ListTile(
                    title: Text('Murkiness: $_latestMurkiness'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
