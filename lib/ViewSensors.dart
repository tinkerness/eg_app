import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorValuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sensors',
          style: GoogleFonts.poppins(
            color: Colors.brown,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.brown),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SensorCardTile(
            sensorName: 'BME680',
            productCode: 'TS1234',
            parameters: ['Temperature', 'Humidity', 'Pressure', 'VOC'],
            imagePath: 'images/BME680.png',
          ),
          SizedBox(height: 16.0),
          SensorCardTile(
            sensorName: 'MQ135',
            productCode: 'GS5678',
            parameters: ['CO2', 'Smoke', 'Benzene', 'Alcohol', 'Sulphur'],
            imagePath: 'images/mq135.png',
          ),
          SizedBox(height: 16.0),
          SensorCardTile(
            sensorName: 'IR Flame Sensor',
            productCode: 'FS9101',
            parameters: ['Flame Detection'],
            imagePath: 'images/Flame.png',
          ),
        ],
      ),
    );
  }
}

class SensorCardTile extends StatelessWidget {
  final String sensorName;
  final String productCode;
  final List<String> parameters;
  final String imagePath;

  SensorCardTile({
    required this.sensorName,
    required this.productCode,
    required this.parameters,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          sensorName,
          style: GoogleFonts.poppins(
            color: Colors.brown,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
              'Product Code: $productCode',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Text('Parameters: ${parameters.join(", ")}'),
          ],
        ),
      ),
    );
  }
}
