import 'package:flutter/material.dart';

class HourlyTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int hour = 1; hour <= 24; hour++)
            Column(
              children: [
                Text(
                  '${hour % 12 == 0 ? 12 : hour % 12}:00',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${hour < 12 ? 'AM' : 'PM'}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
        ],
      ),
    );
  }
}