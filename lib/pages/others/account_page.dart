import 'package:biteupcontent/pages/others/helpdesk_page.dart';
import 'package:biteupcontent/pages/others/order_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:biteupcontent/pages/others/complete_profile.dart';

import '../../widgets/bottom_bar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set status bar color and style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                _buildSection('More Options', [
                  MenuItem(
                    icon: Icons.person_outline,
                    title: 'Edit profile',
                    onTap: () {     Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryAddressScreen(),
                    ),
                  );     },
                  ),
                  MenuItem(
                    icon: Icons.monetization_on_outlined,
                    title: 'Up Coins',
                    onTap: () {},
                  ),
                ]),
                _buildSection('Food Orders', [
                  MenuItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Daily Order',
                    onTap: () {},
                  ),
                  MenuItem(
                    icon: Icons.history,
                    title: 'Order History',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistoryScreen()));
                    },
                  ),
                  MenuItem(
                    icon: Icons.book_outlined,
                    title: 'Address Book',
                    onTap: () {},
                  ),
                ]),
                _buildSection('Support', [
                  MenuItem(
                    icon: Icons.info_outline,
                    title: 'About',
                    onTap: () {},
                  ),
                  
                  MenuItem(
                    icon: Icons.question_answer_outlined,
                    title: 'Frequently asked questions',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpDeskPage()));
                    },
                  ),
                  MenuItem(
                    icon: Icons.feedback_outlined,
                    title: 'Send Feedback',
                    onTap: () {},
                  ),
                  MenuItem(
                    icon: Icons.help_outline,
                    title: 'Help',
                    onTap: () {},
                  ),
                ]),
                const SizedBox(height: 16),
                _buildLogoutButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(selectedIndex: 1),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),

    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink,
            Colors.pink.shade300,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Purvesh Mali',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'purveshmali69@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: items.map((item) => _buildMenuItem(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 24,
              color: Colors.black87,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout,
              size: 20,
              color: Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              'Log out',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}