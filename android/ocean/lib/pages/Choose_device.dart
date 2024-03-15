import 'package:flutter/material.dart';

import 'Get_device_data.dart';

class Choose_device extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Device'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text('Station_1'),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceDetailsPage(deviceName: 'Station_1')),
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text('Station_2'),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceDetailsPage(deviceName: 'Station_2')),
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text('Station_3'),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceDetailsPage(deviceName: 'Station_3')),
              );
            },
          ),
          // Add more ListTile items as needed
        ],
      ),
    );
  }
}
