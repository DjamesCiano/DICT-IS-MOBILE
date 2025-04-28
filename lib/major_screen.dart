import 'dart:async';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart'
    show CurvedNavigationBarItem;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:inventory_system/directory_details.dart';
import 'package:inventory_system/scanning_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';

class MajorScreen extends StatefulWidget {
  @override
  _MajorScreenState createState() => _MajorScreenState();
}

class _MajorScreenState extends State<MajorScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    DirectoryScreen(),
    QRScannerScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 70, // Slightly taller for better design
        backgroundColor: Color(0xFF14468A), // Floating effect
        color: Color(0xFF14468A),
        buttonBackgroundColor: Colors.yellow, // Active button color
        animationDuration: Duration(milliseconds: 400), // Smooth animation
        onTap: _onItemTapped,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.dashboard, color: Colors.white, size: 30),
            label: 'Dashboard',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.folder, color: Colors.white, size: 30),
            label: 'Directory',

            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.qr_code, color: Colors.white, size: 35),
            label: 'QR',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.settings, color: Colors.white, size: 30),
            label: 'Settings',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, color: Colors.white, size: 30),
            label: 'Profile',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _currentTime = "";
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      "title": "OUR APPLICATION",
      "subtitle": "LEARN MORE ABOUT OUR APPLICATION",
    },
    {"title": "FEATURES", "subtitle": "DISCOVER POWERFUL FEATURES"},
    {"title": "UPDATES", "subtitle": "STAY UP TO DATE"},
  ];

  Timer? _timer; // Declare a Timer variable

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => _updateTime());
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat('hh:mm:ss a').format(now);
    });
  }

  void _nextPage() {
    if (_currentIndex < _slides.length - 1) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0Xff14468A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DASHBOARD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "WELCOME DARWIN !",
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.yellow, thickness: 2),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildClockDisplay(_currentTime),
                  ),
                ],
              ),
            ),

            // Slideshow Section
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "MISSION",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 2, 37, 66),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "“DICT of the people and for the people.”",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 35),
                          Text(
                            "VISION",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 2, 37, 66),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "“An innovative, safe and happy nation that thrives through and is enabled by Information and Communications Technology.”",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 35),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Clock Display Function
  List<Widget> _buildClockDisplay(String time) {
    List<String> parts = time.split(" ");
    List<String> timeParts = parts[0].split(":");

    return [
      _timeBox(timeParts[0]), // Hour
      Text(":", style: TextStyle(color: Colors.white, fontSize: 40)),
      _timeBox(timeParts[1]), // Minute
      Text(":", style: TextStyle(color: Colors.white, fontSize: 40)),
      _timeBox(timeParts[2]), // Second
      SizedBox(width: 5),
      Text(
        parts[1],
        style: TextStyle(color: Colors.white, fontSize: 20),
      ), // AM/PM
    ];
  }

  Widget _timeBox(String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        value,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class DirectoryScreen extends StatefulWidget {
  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref(
    "scanned_items",
  );
  List<Map<String, dynamic>> _directoryList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    _database.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          _directoryList =
              data.entries.map((entry) {
                final Map<String, dynamic> item = Map<String, dynamic>.from(
                  entry.value,
                );
                return {
                  "key": entry.key, // Firebase unique key
                  ...item, // Include all fields
                };
              }).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _directoryList = [];
          _isLoading = false;
        });
      }
    });
  }

  void _deleteEntry(String key) async {
    await _database.child(key).remove();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0Xff14468A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Color(0Xff14468A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DIRECTORY",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (query) {
                      setState(() {
                        _directoryList =
                            _directoryList.where((entry) {
                              return entry["Person_Accountable"]
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                            }).toList();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Scrollable Directory List
          Expanded(
            child:
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _directoryList.isEmpty
                    ? Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                    : ListView.builder(
                      itemCount: _directoryList.length,
                      itemBuilder: (context, index) {
                        final item = _directoryList[index];

                        return Card(
                          color: Color(0Xff14468A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: ListTile(
                            title: Text(
                              item["Person_Accountable"],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Designation: ${item["Asset_Classification"]}",
                              style: TextStyle(color: Colors.white70),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          DirectoryDetailScreen(item: item),
                                ),
                              );
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.white),
                                  onPressed: () {
                                    // Implement edit functionality
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.white),
                                  onPressed: () {
                                    _deleteEntry(item["key"]);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),

      // Floating QR Code Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement QR Code functionality
        },
        backgroundColor: Colors.yellow,
        child: Icon(Icons.qr_code, color: Colors.blue),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Settings Screen", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Profile Screen", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
