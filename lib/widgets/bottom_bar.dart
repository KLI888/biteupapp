import 'package:biteupcontent/pages/others/thalis_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key, 
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> 
    with TickerProviderStateMixin {  // Changed this line from SingleTickerProviderStateMixin
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final AnimationController _rotationController = AnimationController(
    duration: const Duration(seconds: 10), // Very slow rotation (10 seconds per rotation)
    vsync: this,
  )..repeat(); // Make it repeat continuously

  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 1.0,
    end: 0.95,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  ));

  bool _isButtonPressed = false;

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Bottom bar container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 30,
                    spreadRadius: 1,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icons.home_rounded,
                    label: 'Home',
                    isSelected: widget.selectedIndex == 0,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // Handle home tap
                    },
                  ),
                  const SizedBox(width: 65),
                  _buildNavItem(
                    icon: Icons.shopping_cart_rounded,
                    label: 'Cart',
                    isSelected: widget.selectedIndex == 2,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // Handle cart tap
                    },
                  ),
                ],
              ),
            ),
          ),
          // Centered thali button
          Positioned(
            top: 0,
            child: GestureDetector(
              onTapDown: (_) {
                setState(() => _isButtonPressed = true);
                _controller.forward();
                HapticFeedback.mediumImpact();
              },
              onTapUp: (_) {
                setState(() => _isButtonPressed = false);
                _controller.reverse();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThaliListingPage()),
                );
              },
              onTapCancel: () {
                setState(() => _isButtonPressed = false);
                _controller.reverse();
              },
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(3.8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(_isButtonPressed ? 0.15 : 0.25),
                        blurRadius: _isButtonPressed ? 15 : 25,
                        spreadRadius: _isButtonPressed ? 1 : 2,
                        offset: Offset(0, _isButtonPressed ? 4 : 8),
                      ),
                    ],
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.pink[300]!,
                          Colors.pink[400]!,
                          Colors.pink[500]!,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: SizedBox(
                      width: 58,
                      height: 58,
                      child: Center(
                        child: RotationTransition(
                          turns: _rotationController,
                          child: Image.asset(
                            'assets/images/thali.png',
                            width: 58,
                            height: 58,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.restaurant_menu_rounded,
                                color: Colors.white,
                                size: 58,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.all(isSelected ? 12 : 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.pink[50] : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.pink[400] : Colors.grey[400],
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: isSelected ? Colors.pink[400] : Colors.grey[400],
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}