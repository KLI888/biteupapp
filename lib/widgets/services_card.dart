import 'package:flutter/material.dart';

class ServiceItem {
  final IconData icon;
  final String label;
  final bool isSelected;

  ServiceItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });
}

class ServiceButtons extends StatelessWidget {
  ServiceButtons({Key? key}) : super(key: key);

  final List<ServiceItem> services = [
    ServiceItem(
      icon: Icons.room_service_outlined,
      label: 'Custom\nOrder',
    ),
    ServiceItem(
      icon: Icons.emoji_events_outlined,
      label: 'Experience',
    ),
    ServiceItem(
      icon: Icons.delivery_dining_outlined,
      label: 'Delivery\nPickup',
    ),
    ServiceItem(
      icon: Icons.local_mall_outlined,
      label: 'Custom\nShop',
      isSelected: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate item width based on available space
        final itemWidth = (constraints.maxWidth - (32 + (12 * (services.length - 1)))) / services.length;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: Colors.transparent,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: services.map((service) => Padding(
                padding: EdgeInsets.only(
                  left: service == services.first ? 16 : 6,
                  right: service == services.last ? 16 : 6,
                ),
                child: ServiceButton(
                  icon: service.icon,
                  label: service.label,
                  isSelected: service.isSelected,
                  width: itemWidth.clamp(70, 100), // Min 70, max 100
                ),
              )).toList(),
            ),
          ),
        );
      },
    );
  }
}

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final double width;

  const ServiceButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.width,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 76),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFCE4EC) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFCE4EC),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFFE91E63),
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFE91E63),
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}