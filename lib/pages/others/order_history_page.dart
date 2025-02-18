import 'package:flutter/material.dart';

// Model classes
class FoodOrder {
  final String name;
  final String description;
  final double rating;
  final String imageUrl;
  final double price;
  final String orderDate;
  final String orderStatus;

  FoodOrder({
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.price,
    required this.orderDate,
    required this.orderStatus,
  });

  factory FoodOrder.fromJson(Map<String, dynamic> json) {
    return FoodOrder(
      name: json['name'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      orderDate: json['orderDate'],
      orderStatus: json['orderStatus'],
    );
  }
}

// Dummy Data
final List<Map<String, dynamic>> dummyOrdersJson = [
  {
    'name': 'Premium Thali',
    'description': 'Customers Choice!',
    'rating': 4.5,
    'imageUrl': 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=375,341',
    'price': 299.0,
    'orderDate': '2025-02-17',
    'orderStatus': 'Delivered'
  },
  {
    'name': 'Base Thali',
    'description': 'Don\'t miss at all!',
    'rating': 4.0,
    'imageUrl': 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=375,341',
    'price': 199.0,
    'orderDate': '2025-02-16',
    'orderStatus': 'In Progress'
  },
  {
    'name': 'Medium Thali',
    'description': 'Worth it!',
    'rating': 4.0,
    'imageUrl': 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=375,341',
    'price': 249.0,
    'orderDate': '2025-02-15',
    'orderStatus': 'Delivered'
  },
  {
    'name': 'Special Veg Thali',
    'description': 'Pure vegetarian delight!',
    'rating': 4.8,
    'imageUrl': 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=375,341',
    'price': 279.0,
    'orderDate': '2025-02-14',
    'orderStatus': 'Delivered'
  },
  {
    'name': 'Festive Thali',
    'description': 'Special festival menu!',
    'rating': 4.7,
    'imageUrl': 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=375,341',
    'price': 399.0,
    'orderDate': '2025-02-13',
    'orderStatus': 'Cancelled'
  }
];

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<FoodOrder> orders;
  bool showCurrentOrders = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Convert dummy JSON data to FoodOrder objects
    orders = dummyOrdersJson.map((json) => FoodOrder.fromJson(json)).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<FoodOrder> get filteredOrders {
    if (showCurrentOrders) {
      return orders.where((order) => order.orderStatus == 'In Progress').toList();
    } else {
      return orders.where((order) => order.orderStatus != 'In Progress').toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Order History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Cart'),
                    Tab(text: 'Orders'),
                  ],
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.pink,
                  indicatorWeight: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showCurrentOrders = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: showCurrentOrders ? Colors.pink[50] : Colors.grey[200],
                            foregroundColor: showCurrentOrders ? Colors.pink : Colors.grey,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Current Order'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showCurrentOrders = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !showCurrentOrders ? Colors.pink : Colors.grey[200],
                            foregroundColor: !showCurrentOrders ? Colors.white : Colors.grey,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Previous Orders'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
              child: Text(
                showCurrentOrders
                    ? 'No current orders'
                    : 'No previous orders',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return _buildOrderCard(order);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(FoodOrder order) {
    return Card(
      elevation: 0,
      color: Colors.grey[50],
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with error handling and loading indicator
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  order.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                        color: Colors.pink,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.restaurant,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Order details with Expanded to prevent overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '₹${order.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.orderStatus).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          order.orderStatus,
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(order.orderStatus),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Wrap stars in SingleChildScrollView to prevent horizontal overflow
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < order.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.pink,
                            size: 16,
                          );
                        }),
                        if (order.rating % 1 != 0)
                          const Icon(
                            Icons.star_half,
                            color: Colors.pink,
                            size: 16,
                          ),
                        const SizedBox(width: 4),
                        Text(
                          order.rating.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ordered on ${order.orderDate}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'In Progress':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}