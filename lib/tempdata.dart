// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class FlameDetectionData extends StatefulWidget {
//   @override
//   _FlameDetectionDataState createState() => _FlameDetectionDataState();
// }

// class _FlameDetectionDataState extends State<FlameDetectionData> {
//   List<Map<String, dynamic>> flameDataList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchFlameData();
//   }

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
