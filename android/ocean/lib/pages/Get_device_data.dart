import 'package:flutter/material.dart';

class DeviceDetailsPage extends StatefulWidget {
  final String deviceName;

  const DeviceDetailsPage({Key? key, required this.deviceName}) : super(key: key);

  @override
  _DeviceDetailsPageState createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  late bool _isToggled; // Indicates whether the toggle is on or off

  @override
  void initState() {
    super.initState();
    _isToggled = false; // Initially, toggle is off
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deviceName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Show current data'), // Text on the left
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
                    color: _isToggled ?  Color(0xFF65C466) : Color(0xFFE9E9EB), // Color based on toggle state
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
          // Add more content as needed
        ],
      ),
    );
  }
}