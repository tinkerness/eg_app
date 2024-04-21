import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(
            color: Colors.brown,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.brown),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Your Privacy Matters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'EnviroGuard provides you with accurate indoor air quality data based on the specific location. Our team is committed to providing data rights to users under CCPA Regulations.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'What data do we collect?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We DO NOT collect any personal data such as Email IDs, phone-numbers, or Addresses for purposes other than sending you accurate air quality information or software products such as sensors and account information as ordered by you.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: PolicyPage(),
//     theme: ThemeData(
//       // Define the default brightness and colors.
//       brightness: Brightness.light,
//       primaryColor: Colors.brown,
//       // accentColor: Colors.brown,
//     ),
//   ));
// }
