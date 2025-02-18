import 'package:flutter/material.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/bottom_bar_two.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;

    // Responsive text sizes
    final smallText = screenWidth * 0.035;
    final mediumText = screenWidth * 0.04;
    final largeText = screenWidth * 0.045;

    return Scaffold(
      body: Stack(
        children: [
          // App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: BiteupAppBar(),
          ),

          // Main Content
          Positioned(
            top: kToolbarHeight + padding.top,
            left: 0,
            right: 0,
            bottom: 56.0, // Bottom navigation bar height
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    // Delivery Info
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.pink, size: mediumText * 1.2),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Text(
                            'Delivery at Shivajinagar, Pune',
                            style: TextStyle(fontSize: smallText),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey, size: mediumText * 1.2),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Delivery in 40 mins',
                          style: TextStyle(fontSize: smallText, color: Colors.grey[600]),
                        ),
                      ],
                    ),

                    // Amount Details
                    SizedBox(height: screenHeight * 0.03),
                    _buildAmountRow('Thali amount', '₹50', smallText),
                    _buildAmountRow('GST (18%)', '₹10', smallText),
                    _buildAmountRow('Payable Amount', '₹60', mediumText, true),

                    // Offers Section
                    Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green[100]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '30% off on First Order',
                            style: TextStyle(
                              fontSize: smallText,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            children: [
                              Icon(Icons.local_offer, color: Colors.green, size: smallText * 1.2),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                'Free Delivery on First Order',
                                style: TextStyle(
                                  fontSize: smallText,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // UPI Apps Section
                    Text(
                      'Pay directly with your favourite UPI apps',
                      style: TextStyle(fontSize: smallText, color: Colors.grey[700]),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildUPIOption('GPay', 'assets/images/gpay.png', screenWidth),
                        _buildUPIOption('PhonePe', 'assets/images/phonepe.png', screenWidth),
                        _buildUPIOption('BHIM', 'assets/images/bhim.png', screenWidth),
                        _buildUPIOption('Paytm', 'assets/images/paytm.png', screenWidth),
                      ],
                    ),

                    // Other UPI Apps Button
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pay with other UPI apps',
                            style: TextStyle(
                              fontSize: smallText,
                              color: Colors.blue[700],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: smallText * 1.2),
                        ],
                      ),
                    ),

                    // Other Payment Methods
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      'Other Payments Methods',
                      style: TextStyle(
                        fontSize: mediumText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Swipe to Pay Button
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.swipe, color: Colors.pink),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Swipe to Pay',
                            style: TextStyle(
                              fontSize: smallText,
                              color: Colors.pink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Additional Payment Options
                    SizedBox(height: screenHeight * 0.02),
                    _buildPaymentOption('Paytm UPI', Icons.payment, screenWidth, screenHeight),
                    _buildPaymentOption('Credit/Debit Card', Icons.credit_card, screenWidth, screenHeight),
                    _buildPaymentOption('Net Banking', Icons.account_balance, screenWidth, screenHeight),

                    // Add extra padding at bottom to ensure content isn't hidden behind bottom bar
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Navigation Bar
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

  // Your existing helper methods remain the same
  Widget _buildAmountRow(String label, String amount, double fontSize, [bool isBold = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUPIOption(String name, String imagePath, double screenWidth) {
    return Column(
      children: [
        Container(
          width: screenWidth * 0.15,
          height: screenWidth * 0.15,
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(fontSize: screenWidth * 0.03),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.015,
        horizontal: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: screenWidth * 0.06, color: Colors.grey[600]),
          SizedBox(width: screenWidth * 0.03),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}