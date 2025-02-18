import 'package:biteupcontent/widgets/hot_menu.dart';
import 'package:biteupcontent/widgets/services_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/breakfast_section.dart';
import '../../widgets/top_bar.dart';
import 'package:biteupcontent/widgets/bottom_bar.dart';

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
              // Now passing the _isScrolled state to CustomSliverAppBar
              CustomSliverAppBar(isScrolled: _isScrolled),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServiceButtons(),

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
                          HotMenuSection(),

                          const SizedBox(height: 24),

                          const Text(
                            'BreakFast',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BreakfastList(),
                          const SizedBox(height: 100),
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


