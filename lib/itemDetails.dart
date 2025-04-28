import 'package:flutter/material.dart';
import 'package:inventory_system/login_screen.dart';
import 'package:inventory_system/major_screen.dart';
import 'package:inventory_system/scanning_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  ItemDetailsScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          // Background Image (Top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 350, // Slightly taller for a smooth overlap
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/dict_office.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Details Card (Blue Container)
          Positioned(
            top: 300, // Adjust this value for more or less overlap
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Color(0xFF002F6C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _buildDetailItem(
                    //   "Property Number:",
                    //   data["Property Number"],
                    // ),
                    _buildDetailItem(
                      "Asset Classification:",
                      data["Asset Classification"],
                    ),
                    _buildDetailItem("Brand/Model:", data["Brand/Model"]),
                    // _buildDetailItem("Serial Number:", data["Serial Number"]),
                    // _buildDetailItem(
                    //   "Acquisition Cost:",
                    //   "Php ${data["Acquisition Cost"]}",
                    // ),
                    _buildDetailItem(
                      "Acquisition Date:",
                      data["Acquisition Date"],
                    ),
                    _buildDetailItem("Location:", data["Location"]),
                    _buildDetailItem(
                      "Person Accountable:",
                      data["Person Accountable"],
                    ),
                    SizedBox(height: 30),

                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFD700),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QRScannerScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "CAPTURE AGAIN",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MajorScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "BACK",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String? value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: RichText(
        text: TextSpan(
          text: "$label\n",
          style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: value ?? "N/A",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
