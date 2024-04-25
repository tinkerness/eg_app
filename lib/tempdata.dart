// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AllData extends StatefulWidget {
  @override
  _AllDataState createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  // final databaseReference = FirebaseDatabase.instance.ref().child('sensors');
  // late DatabaseReference bmeDataReference;
  List<Map<String, dynamic>> _BMEData = [];

  @override
  void initState() {
    super.initState();
    // bmeDataReference = databaseReference.child('BME680');
    fetchBMEData();
  }

  // Future<void> fetchBMEData() async {
  void fetchBMEData() async {
    try {
      final databaseReference = FirebaseDatabase.instance.reference();
      final bmeDataReference = databaseReference.child('sensors/BME680');
      DataSnapshot snapshot = (await bmeDataReference.once()) as DataSnapshot;

      setState(() {
        _BMEData = []; // Reset _BMEData here
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        //  as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          _BMEData.add({
            'documentId': key,
            'dayOfMonth': value['dayOfMonth'],
            'time': value['time'],
            'temperature': value['temperature'],
            'humidity': value['humidity'],
            'pressure': value['pressure'],
          });
          print('BME680 Data: $value');
        });
      });
    } catch (e) {
      print("Error fetching data: $e");
      // Handle error if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Fetched Data'),
      ),
      body: ListView.builder(
        itemCount: _BMEData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_BMEData[index]['documentId']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Day of Month: ${_BMEData[index]['dayOfMonth']}'),
                Text('Temperature: ${_BMEData[index]['temperature']}'),
                Text('Humidity: ${_BMEData[index]['humidity']}'),
                Text('Pressure: ${_BMEData[index]['pressure']}'),
                Text('Time: ${_BMEData[index]['time']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}


//   void fetchFlameData() {
//     final DatabaseReference flameRef = FirebaseDatabase.instance.ref('sensors/Flame');
//     flameRef.onValue.listen((event) {
//       final data = event.snapshot.value;
    
//     if (data != null && data is Map<dynamic, dynamic>) {
//         // Extracting the latest humidity value
//         final latestFlame = data.values.first['flameDetected'];

//       if (latestFlame != null && latestHumidity is num) {
//           setState(() {
//             Humidity = latestHumidity.toInt();

//     flameRef.once().then((DataSnapshot snapshot) {
//       if (snapshot.value != null) {
//         Map<dynamic, dynamic> flameDataMap = snapshot.value;
//         flameDataMap.forEach((key, value) {
//           if (value['dayOfMonth'] is int) {
//             flameDataList.add(value);
//           }
//         });

//         // Sort the list based on timestamp (you can customize the sorting logic as needed)
//         flameDataList.sort((a, b) {
//           return b['dayOfMonth'].compareTo(a['dayOfMonth']);
//         });

//         setState(() {});
//       }
//     }, onError: (error) {
//       print('Error fetching Flame data: $error');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flame Detection Data'),
//       ),
//       body: ListView.builder(
//         itemCount: flameDataList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(
//               'Flame Detection: ${flameDataList[index]['flameDetected'] == 1 ? 'Detected' : 'Not Detected'}',
//             ),
//             subtitle: Text(
//               'Date: ${flameDataList[index]['dayOfMonth']} ${flameDataList[index]['month']} ${flameDataList[index]['year']}',
//             ),
//             trailing: Text(
//               'Time: ${flameDataList[index]['time']}',
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }}
