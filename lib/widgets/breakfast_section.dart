import 'package:flutter/material.dart';

class BreakfastList extends StatelessWidget {
  const BreakfastList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth < 400
            ? constraints.maxWidth * 0.6
            : constraints.maxWidth * 0.4;

        return SizedBox(
          height: itemWidth * 0.55, // Maintain aspect ratio
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
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

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: BreakfastCard(
                  title: items[index]['title']!,
                  price: items[index]['price']!,
                  imageUrl: items[index]['imageUrl']!,
                  width: itemWidth,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BreakfastCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final double width;

  const BreakfastCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background image with gradient overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[100],
                      child: const Icon(Icons.error, color: Colors.grey),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content overlay
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
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