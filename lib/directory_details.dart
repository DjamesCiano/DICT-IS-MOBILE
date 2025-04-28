import 'package:flutter/material.dart';

class DirectoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  DirectoryDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Asset Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0Xff14468A),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ASSET INFORMATION",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0Xff14468A),
                  ),
                ),
                Divider(color: Colors.grey[400]),
                SizedBox(height: 10),

                buildDetailRow("Property Number", item["Property_Number"]),
                buildDetailRow(
                  "Asset Classification",
                  item["Asset_Classification"],
                ),
                buildDetailRow("Brand/Model", item["Brand_Model"]),
                buildDetailRow("Serial Number", item["Serial_Number"]),
                buildDetailRow(
                  "Acquisition Cost",
                  "Php ${item["Acquisition_Cost"] ?? "N/A"}",
                ),
                buildDetailRow("Acquisition Date", item["Acquisition_Date"]),
                buildDetailRow("Location", item["Location"]),
                buildDetailRow(
                  "Person Accountable",
                  item["Person_Accountable"],
                ),

                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Back"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0Xff14468A),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value ?? "N/A",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }
}
