import 'package:biteupcontent/pages/others/ordernow_page.dart';
import 'package:biteupcontent/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/bottom_bar_two.dart';

class HungerBoxPage extends StatefulWidget {
  const HungerBoxPage({Key? key}) : super(key: key);

  @override
  State<HungerBoxPage> createState() => _HungerBoxPageState();
}

class _HungerBoxPageState extends State<HungerBoxPage> {
  final Map<String, int> quantities = {
    'Roti': 1,
    'Bhaji': 1,
    'Rice': 1,
  };

  final Map<String, double> prices = {
    'Roti': 10.0,
    'Bhaji': 50.0,
    'Rice': 25.0,
  };

  double get totalAmount {
    double total = 0;
    quantities.forEach((key, value) {
      total += value * prices[key]!;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final plateSize = screenWidth * 0.90;
    final appBarHeight = kToolbarHeight + 20 + MediaQuery.of(context).padding.top;
    final bottomBarHeight = 56.0; // Standard bottom navigation bar height

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Fixed Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: BiteupAppBar(),
          ),

          // Main Scrollable Content
          Positioned(
            top: appBarHeight,
            left: 0,
            right: 0,
            bottom: bottomBarHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top section with side by side layout
                  Container(
                    height: plateSize + 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side - Menu section
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Basic ',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.pink[400],
                                      ),
                                    ),
                                    Text(
                                      'Hungerbox',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenWidth * 0.03),
                                Text(
                                  'Choose from menu',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: screenWidth * 0.04),
                                _buildSelectionField('Select Roti Type'),
                                _buildSelectionField('Select Bhaji'),
                                _buildSelectionField('Select Rice'),
                                _buildSelectionField('Select Desert'),
                              ],
                            ),
                          ),
                        ),

                        // Right side - Plate image
                        Expanded(
                          flex: 2,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                right: -plateSize * 0.35,
                                top: 30,
                                child: Container(
                                  width: plateSize,
                                  height: plateSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/thali.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Customize Your Meal Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Customize Your Meal',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Icon(
                              Icons.arrow_upward,
                              size: screenWidth * 0.04,
                              color: Colors.pink[400],
                            ),
                          ],
                        ),
                        SizedBox(height: screenWidth * 0.04),

                        // Menu Items
                        _buildCustomMenuItem('Roti', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJCsNQJxG5zy8ScNn5KbnnmgzPB_Stz3QGRg&s', quantities['Roti']!, prices['Roti']!),
                        _buildCustomMenuItem('Bhaji', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJCsNQJxG5zy8ScNn5KbnnmgzPB_Stz3QGRg&s', quantities['Bhaji']!, prices['Bhaji']!),
                        _buildCustomMenuItem('Rice', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJCsNQJxG5zy8ScNn5KbnnmgzPB_Stz3QGRg&s', quantities['Rice']!, prices['Rice']!),

                        // SizedBox(height: screenWidth * 0.06),

                        // Order Button Row
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.06,
                                vertical: screenWidth * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink[400],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '₹${totalAmount.toStringAsFixed(0)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown[800],
                                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'ORDER NOW',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: screenWidth * 0.04),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(selectedIndex: 1),
          ),
        ],
      ),
    );
  }

// Your existing _buildSelectionField and _buildCustomMenuItem methods remain the same
  Widget _buildSelectionField(String text) {
    return Container(
      // width: double.infinity,
      width: 100,
      height: MediaQuery.of(context).size.width * 0.11,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.pink[400],
              fontSize: MediaQuery.of(context).size.width * 0.035,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomMenuItem(String item, String imagePath, int quantity, double price) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: Row(
        children: [
          // Food Image
          Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),

          // Item Name
          Text(
            item,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),

          // Quantity Controls
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenWidth * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (quantities[item]! > 1) {
                        quantities[item] = quantities[item]! - 1;
                      }
                    });
                  },
                  child: Icon(Icons.remove, size: screenWidth * 0.045, color: Colors.pink[400]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  child: Text(
                    quantity.toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      quantities[item] = quantities[item]! + 1;
                    });
                  },
                  child: Icon(Icons.add, size: screenWidth * 0.045, color: Colors.pink[400]),
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.03),

          // Price
          Text(
            '₹${price.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}





