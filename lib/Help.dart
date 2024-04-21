import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to the Help Center!',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Frequently Asked Questions:',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 10),
            FAQWidget(
              question: 'I forgot my password. What should I do?',
              answer:
                  'You can reset your password by tapping on the Can\'t Access Account link on the login screen.',
            ),
            // Add more FAQWidget as needed
            SizedBox(height: 20),
            Text(
              'Troubleshooting:',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 10),
            TroubleshootingWidget(
              issue: 'App crashes on startup',
              solution:
                  'Try reinstalling the app and ensure you have a stable internet connection.',
            ),
            // Add more TroubleshootingWidget as needed
            SizedBox(height: 20),
            Text(
              'Contact Us:',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 10),
            ContactWidget(),
          ],
        ),
      ),
    );
  }
}

class FAQWidget extends StatelessWidget {
  final String question;
  final String answer;

  FAQWidget({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}

class TroubleshootingWidget extends StatelessWidget {
  final String issue;
  final String solution;

  TroubleshootingWidget({required this.issue, required this.solution});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        issue,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            solution,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}

class ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'For further assistance, please contact us:',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.email, color: Colors.brown),
            SizedBox(width: 5),
            InkWell(
              onTap: () async {
                // await _launchEmail(); // Call function to open email
              },
              child: Text(
                'alanjoy905@example.com',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.phone, color: Colors.brown),
            SizedBox(width: 5),
            InkWell(
              onTap: () {
                // _launchPhone(); // Call function to make phone call
              },
              child: Text(
                '+918304850651',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Function to open email
  Future<void> _launchEmail() async {
    const email = 'mailto:alanjoy905@example.com';
    try {
      if (await canLaunch(email)) {
        await launch(email);
      } else {
        throw 'Could not launch $email';
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  // Function to make phone call
  _launchPhone() async {
    const phoneNumber = 'tel:+918304850651';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
