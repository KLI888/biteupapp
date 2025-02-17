import 'package:biteupcontent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 80 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 80 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Animated App Bar
              // SliverAppBar(
              //   expandedHeight: 120,
              //   floating: false,
              //   pinned: true,
              //   elevation: 0,
              //   backgroundColor: _isScrolled ? Colors.pink[400] : Colors.transparent,
              //   flexibleSpace: FlexibleSpaceBar(
              //     background: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.pink[400],
              //         image: const DecorationImage(
              //           image: NetworkImage('https://img.freepik.com/free-photo/indian-food-circular-plate_23-2148723458.jpg'),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     title: AnimatedOpacity(
              //       opacity: _isScrolled ? 1.0 : 0.0,
              //       duration: const Duration(milliseconds: 200),
              //       child: const Text(
              //         'Biteup',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              //   leading: const Icon(Icons.person_outline, color: Colors.white),
              //   actions: const [
              //     Padding(
              //       padding: EdgeInsets.only(right: 16),
              //       child: Icon(Icons.wallet_outlined, color: Colors.white),
              //     ),
              //   ],
              // ),

              // Main Content
              CustomSliverAppBar(isScrolled: true,),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Action Buttons
                    // _buildActionButtons(isSelected: ),

                    // Hot Menu Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hot Menu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildHotMenuGrid(),

                          const SizedBox(height: 24),

                          // Breakfast Section
                          const Text(
                            'BreakFast',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildBreakfastList(),
                          const SizedBox(height: 100), // Bottom padding for nav bar
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

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

  Widget _buildActionButtons(String s, IconData room_service_outlined, {required bool isSelected}) {
    return SizedBox(
      height: 85,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          _buildActionButtons('Custom\nOrder', Icons.room_service_outlined, isSelected: false),
          const SizedBox(width: 12),
          _buildActionButtons('Experience', Icons.emoji_events_outlined, isSelected: false),
          const SizedBox(width: 12),
          _buildActionButtons('Delivery\nPickup', Icons.delivery_dining_outlined, isSelected: false),
          const SizedBox(width: 12),
          _buildActionButtons('Custom\nOrder', Icons.room_service_outlined, isSelected: true),
        ],
      ),
    );
  }

  Widget _buildHotMenuGrid() {
    return LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.85,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              // if (index == 5) return _buildSeeAllButtons();
              final items = [
                {'name': 'Aalu Sabji', 'price': '₹68', 'discount': '30%'},
                {'name': 'Matar Paneer', 'price': '₹68', 'discount': '30%'},
                {'name': 'Paneer Masala', 'price': '₹68', 'discount': '30%'},
                {'name': 'Kadhai Paneer', 'price': '₹68', 'discount': '30%'},
                {'name': 'Raita', 'price': '₹68', 'discount': '30%'},
              ];
              return _buildMenuItem(
                items[index]['name']!,
                items[index]['price']!,
                items[index]['discount']!,
              );
            },
          );
        }
    );
  }

  Widget _buildBreakfastList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          final items = [
            {
              'title': 'Oatmeals',
              'price': '₹ 20/unit',
              'imageUrl': 'https://images.unsplash.com/photo-1517673400267-0251440c45dc',
            },
            {
              'title': 'Green Salads',
              'price': '₹ 25/unit',
              'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
            },
            {
              'title': 'Colorful Salads',
              'price': '₹ 30/unit',
              'imageUrl': 'https://images.unsplash.com/photo-1540420773420-3366772f4999',
            },
          ];
          return BreakfastItem(
            title: items[index]['title']!,
            price: items[index]['price']!,
            imageUrl: items[index]['imageUrl']!,
          );
        },
      ),
    );
  }

// Rest of the widget methods (BreakfastItem, _buildMenuItem, etc.) remain the same
// ... (include the previous implementations of these widgets)
}

class BreakfastItem extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const BreakfastItem({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.pink[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Modifications to the _buildMenuItem widget to match the image
Widget _buildMenuItem(String name, String price, String discount) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                'https://example.com/food.jpg', // Replace with actual food images
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            price,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Save ${discount}',
                            style: TextStyle(
                              color: Colors.pink[400],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pink[400],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Free',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Updated _buildBottomNavBar to match the image
Widget _buildBottomNavBar() {
  return Container(
    height: 60,
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.home, color: Colors.pink[400], size: 28),
        Icon(Icons.restaurant_menu, color: Colors.grey[400], size: 28),
        Icon(Icons.shopping_cart_outlined, color: Colors.grey[400], size: 28),
      ],
    ),
  );
}