import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inventory_system/itemDetails.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String scannedData = "";
  final DatabaseReference _database = FirebaseDatabase.instance.ref(
    "scanned_items",
  );
  bool isProcessing = false;
  bool scanCompleted = false;

  void _handleScannedData(String rawData) {
    if (scanCompleted) return;

    setState(() {
      isProcessing = true;
      scanCompleted = true;
    });

    try {
      final Map<String, dynamic> scannedJson = jsonDecode(rawData);

      if (_validateScannedData(scannedJson)) {
        _uploadToFirebase(scannedJson);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(data: scannedJson),
          ),
        ).then((_) {
          setState(() => scanCompleted = false);
        });
      } else {
        _setError("Invalid QR Code: Missing Fields");
      }
    } catch (e) {
      _setError("Invalid QR Code Format");
    }
  }

  bool _validateScannedData(Map<String, dynamic> data) {
    return data.containsKey('Property Number') &&
        data.containsKey('Asset Classification') &&
        data.containsKey('Brand/Model') &&
        data.containsKey('Serial Number') &&
        data.containsKey('Acquisition Cost') &&
        data.containsKey('Acquisition Date') &&
        data.containsKey('Location') &&
        data.containsKey('Person Accountable');
  }

  Future<void> _uploadToFirebase(Map<String, dynamic> scannedJson) async {
    try {
      String newKey =
          _database.push().key ??
          DateTime.now().millisecondsSinceEpoch.toString();

      Map<String, dynamic> uploadData = {
        "Property_Number": scannedJson["Property Number"] ?? "N/A",
        "Asset_Classification": scannedJson["Asset Classification"] ?? "N/A",
        "Brand_Model": scannedJson["Brand/Model"] ?? "N/A",
        "Serial_Number": scannedJson["Serial Number"] ?? "N/A",
        "Acquisition_Cost": scannedJson["Acquisition Cost"] ?? "N/A",
        "Acquisition_Date": scannedJson["Acquisition Date"] ?? "N/A",
        "Location": scannedJson["Location"] ?? "N/A",
        "Person_Accountable": scannedJson["Person Accountable"] ?? "N/A",
        "timestamp": ServerValue.timestamp,
      };

      await _database.child(newKey).set(uploadData);

      setState(() {
        scannedData = "Upload Successful ✅";
        isProcessing = false;
      });
    } catch (e) {
      setState(() {
        scannedData = "Upload Failed ❌: ${e.toString()}";
        isProcessing = false;
      });
    }
  }

  void _setError(String message) {
    setState(() {
      scannedData = message;
      isProcessing = false;
      scanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Ensure camera renders properly
          Positioned.fill(
            child: MobileScanner(
              onDetect: (capture) {
                if (!scanCompleted) {
                  for (final barcode in capture.barcodes) {
                    if (barcode.rawValue != null) {
                      _handleScannedData(barcode.rawValue!);
                      break;
                    }
                  }
                }
              },
            ),
          ),

          // ✅ Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Dark overlay
            ),
          ),

          // ✅ Scanning Box (With Transparent Center)
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/scan.png",
                      width: 150,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Bottom Status Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF14468A).withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isProcessing)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  SizedBox(height: 16),
                  Text(
                    scannedData.isEmpty
                        ? "SCANNING..."
                        : "RESULT: $scannedData",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "STATUS",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
