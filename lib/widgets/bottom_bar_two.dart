import 'package:flutter/material.dart';

class BiteupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BiteupAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the status bar height
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(
        color: Colors.pink[400],
      ),
      child: Column(
        children: [
          // This container takes up status bar space with the same color
          Container(
            height: statusBarHeight,
            color: Colors.pink[400],
          ),
          // Main AppBar content
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Profile Icon and Title Section
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Biteup',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Shivajinagar, Pune',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Wallet Icon
                const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
