import 'package:biteupcontent/pages/others/dishView_page.dart';
import 'package:flutter/material.dart';

class ThaliListingPage extends StatelessWidget {
  const ThaliListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Filter Section
                _buildFilterSection(),
                
                // Offers Section
                _buildOffersSection(),
                
                // Thali Listing
                _buildThaliList(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      children: [
        // First Row - All Day and Advance Order
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              _buildChip('All Day', true, null),
              const SizedBox(width: 8),
              _buildChip('Advance Order', false, null),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Second Row - Veg, Non-Veg, Jain
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _buildChip('Veg', true, Colors.green),
                const SizedBox(width: 8),
                _buildChip('Non-Veg', false, Colors.red),
                const SizedBox(width: 8),
                _buildChip('Jain', false, null),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, bool isSelected, Color? dotColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOffersSection() {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildOfferCard('50% Off', 'use FIRSTBITE|Above 120', Colors.blue[50]!),
          _buildOfferCard('41', 'use WELCOME50', Colors.purple[50]!),
        ],
      ),
    );
  }

  Widget _buildOfferCard(String title, String subtitle, Color bgColor) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThaliList({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Thalis (3)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          ],
        ),
        const SizedBox(height: 12),
        _buildThaliItem(
          context: context,
          name: 'Base Thali',
          price: '₹60',
          description: 'Flattened Wheat dough heated in a flat pan...',
          imageUrl: 'https://www.cubesnjuliennes.com/wp-content/uploads/2020/01/Chicken-Biryani.jpg',
          region: 'Maharashtrian',
          isVeg: true,
        ),
        const SizedBox(height: 12),
        _buildThaliItem(
          context: context,
          name: 'Medium Thali',
          price: '₹80',
          description: 'Flattened Wheat dough heated in a flat pan...',
          imageUrl: 'https://www.cubesnjuliennes.com/wp-content/uploads/2020/01/Chicken-Biryani.jpg',
          region: 'Maharashtrian',
          isVeg: true,
        ),
      ],
    );
  }

  Widget _buildThaliItem({
    required BuildContext context,
    required String name,
    required String price,
    required String description,
    required String imageUrl,
    required String region,
    required bool isVeg,
  }) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Veg indicator and piece info
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 12,
                        color: isVeg ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '2 Piece',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 24),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'read more',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Taste of region: ',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        region,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.eco, size: 12, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          '25-50 XOFF',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Right side image and add button
            const SizedBox(width: 12),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 88,
                    height: 88,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.error),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 28,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.pink,
                      side: const BorderSide(color: Colors.pink),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: InkWell(
                      onTap: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HungerBoxPage()))
                      },
                      child: Text(
                      'ADD',
                      style: TextStyle(fontSize: 12),
                    ),
                    ),
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