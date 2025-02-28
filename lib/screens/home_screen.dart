import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16), // Left padding for alignment
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"), // Change to your profile image
            radius: 16,
          ),
        ),
        title: Text("Dogesh"),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pet’s Routine", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                CircularPercentIndicator(
                  radius: 40.0,
                  lineWidth: 8.0,
                  percent: 0.8,
                  center: Text("80%"),
                  progressColor: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  RoutineCard("Morning Walk", "06:00 - 07:00 am", "Completed", Colors.green),
                  RoutineCard("Feeding Time", "08:00 - 08:30 am", "On Progress", Colors.blue),
                  RoutineCard("Training Session", "10:00 - 11:00 am", "Pending", Colors.yellow),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class RoutineCard extends StatelessWidget {
  final String title;
  final String time;
  final String status;
  final Color statusColor;

  RoutineCard(this.title, this.time, this.status, this.statusColor);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.blue),
                SizedBox(width: 5),
                Text(time, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            Divider(height: 20, thickness: 1, color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Task Status", style: TextStyle(color: Colors.grey[700])),
                Container(
                  width: 100, // Fixed width for consistency
                  padding: EdgeInsets.symmetric(vertical: 6),
                  alignment: Alignment.center, // Ensures text is centered
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
