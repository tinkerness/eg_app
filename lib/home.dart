import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'tempdata.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomePage();
}

class HomePage extends State<Home> with TickerProviderStateMixin {
  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  // final _database= FirebaseDatabase.instance.ref();
  //  DatabaseReference starCountRef =
  //       FirebaseDatabase.instance.ref('sensors/BME680/humidity');

  int currentIndex = 0;
  int myindex = 0;
  num Temp = 25;
  num Pressure = 20;
  num Humidity = 20;
  String Flame = '';
  String So2 = "25";
  String Co2 = "25";
  String Benzene = "25";
  String NH3 = "25";
  String Alcohol = "25";

  @override
  void initState() {
    super.initState();
    retrieveLatestBME680();
    retrieveLatestFlame();
  }

  void retrieveLatestBME680() {
    print("in retrieveLatestBME680!");
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('sensors/BME680');
    databaseReference.onValue.listen((event) {
      final data = event.snapshot.value;

      if (data != null && data is Map<dynamic, dynamic>) {
        // Extracting the latest humidity value
        final latestHumidity = data.values.last['humidity'];
        final latestPressure = data.values.last['pressure'];
        final latestTemp = data.values.last['temperature'];
        final bmedate = data.values.last['dayOfMonth'];
        final bmetime = data.values.last['time'];
        print('1.Latest Humidity from database: $latestTemp');
        print('1.Latest Pressure from database: $latestPressure');
        print('1.Latest Temp from database: $latestTemp');

        if (latestHumidity != null && latestHumidity is num) {
          setState(() {
            Humidity = latestHumidity.toInt();
            Pressure = latestPressure.toInt();
            Temp = latestTemp.toInt(); // Assuming humidity is of type double
          });
          print('2.Latest Humidity from database: $Humidity');
          print('2.Latest Pressure from database: $Pressure');
          print('2.Latest Temp from database: $Temp');
          print('2.bmedate: $bmedate, bmetime: $bmetime');
        } else {
          print('2.Invalid humidity value received from the latest document.');
        }
      } else {
        print('1.No data available or invalid data format.');
      }
    });
  }

  void retrieveLatestFlame() {
    DatabaseReference Flame_ref =
        FirebaseDatabase.instance.ref('sensors/Flame');

    Flame_ref.onValue.listen((event) {
      final data = event.snapshot.value;
      print('1.Flame data: $Flame');

      if (data != null && data is Map<dynamic, dynamic>) {
        // Get the latest entry
        final latestEntryKey = data.keys.last;
        final latestEntry = data[latestEntryKey];

        // Access specific field
        final latestFlameDetected = latestEntry['flameDetected'];
        final flamedate = latestEntry['dayOfMonth'];
        final flametime = latestEntry['time'];

        // Assuming you're using setState within a StatefulWidget
        setState(() {
          Flame = latestFlameDetected == 1 ? 'Detected' : 'Not Detected';
          // print("3.latestFlame: $latestFlame");
          // print("4.latestFlame['flameDetected']: $latestFlame['flameDetected']");
        });

        print(
            '5.Latest Flame from database: $Flame, day: $flamedate, time: $flametime');
      } else {
        print('6.No data available or invalid data format.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with blur effect
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "images/breathe.jpg"), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),

          // Content on top of the background image
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(35),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hello, Allwina ',
                              style: GoogleFonts.poppins(
                                color: Colors.brown,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '         ', // Add space here
                            ),
                            TextSpan(
                              text: '$Temp  °C',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(
                  //   height: 10.0,
                  // ),

                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                    ),
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Indoor Air Quality Index",
                          style: GoogleFonts.dmSerifDisplay(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 130,
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                minimum: 0,
                                maximum: 150,
                                ranges: <GaugeRange>[
                                  GaugeRange(
                                      startValue: 0,
                                      endValue: 50,
                                      color: Colors.green,
                                      startWidth: 10,
                                      endWidth: 10),
                                  GaugeRange(
                                      startValue: 50,
                                      endValue: 100,
                                      color: Colors.orange,
                                      startWidth: 10,
                                      endWidth: 10),
                                  GaugeRange(
                                      startValue: 100,
                                      endValue: 150,
                                      color: Colors.red,
                                      startWidth: 10,
                                      endWidth: 10)
                                ],
                                pointers: const <GaugePointer>[
                                  NeedlePointer(
                                    value: 90,
                                    needleEndWidth: 3,
                                  )
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                      widget: Container(
                                          child: const Text('\n\n90.0',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      angle: 90,
                                      positionFactor: 0.5)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  Text(
                    "Predict the quality of the air",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                  ),

                  const SizedBox(height: 5.0), // Adding some space
                  ElevatedButton(
                    onPressed: () {
                      // Handle button tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FlameDetectionData()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.brown, // Text color
                    ),
                    child: const Text('PREDICT'),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "Major Air Parameters",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),

                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Adjust alignment as needed
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'So2',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('$So2'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5, // Adjust the gap between containers
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Co2',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('$Co2'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10), // Add space between rows

                        // Add additional rows here
                        // Row 1
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Pressure',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('$Pressure'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Humidity',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('$Humidity'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Row 2 (similar to Row 1 structure, adjust contents as needed)
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Benzene',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('$Benzene'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Text(
                                        'NH3',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('$NH3'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Row 3 (similar to Row 1 structure, adjust contents as needed)
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Flame',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('$Flame'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width *
                                      0.9 /
                                      2,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Alcohol',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('$Alcohol'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Row 4 (similar to Row 1 structure, adjust contents as needed)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlameDetectionData() {}
  // InfluxDBDataScreen() {}
}
