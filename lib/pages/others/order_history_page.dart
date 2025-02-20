import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFE91E63),
      ),
      body: Column(
        children: [
          _buildCalendar(),
          Expanded(
            child: _buildOrderList(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCalendar() {
  DateTime now = DateTime.now();
  DateTime lastDay = DateTime(2024, 12, 31);

  // Ensure focusedDay is not after lastDay
  if (now.isAfter(lastDay)) {
    now = lastDay; // Set focusedDay to lastDay if the current day is later
  }

  return Container(
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: TableCalendar(
      firstDay: DateTime(2024, 1, 1),
      lastDay: lastDay,
      focusedDay: now, // Set the updated focusedDay
      currentDay: now,
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Color(0xFFE91E63),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Color(0xFFE91E63).withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
    ),
  );
}


  Widget _buildOrderList() {
    final items = [
      {
        'title': 'Premium Thali',
        'date': 'Delivered on 18 Oct, 2024',
        'image': 'assets/images/premium_thali.png'
      },
      {
        'title': 'Base Thali',
        'date': 'Delivered on 18 Sept, 2024',
        'image': 'assets/images/base_thali.png'
      },
      {
        'title': 'Medium Thali',
        'date': 'Delivered on 18 Sept, 2024',
        'image': 'assets/images/medium_thali.png'
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildOrderItem(
          items[index]['title']!,
          'We are glad you liked this dish!',
          4,
          items[index]['date']!,
          items[index]['image']!,
        );
      },
    );
  }

  Widget _buildOrderItem(String title, String subtitle, int rating, String deliveryDate, String imagePath) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(subtitle),
            SizedBox(height: 4),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Color(0xFFE91E63),
                  size: 20,
                ),
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  deliveryDate,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
      ],
      selectedItemColor: Color(0xFFE91E63),
    );
  }
}