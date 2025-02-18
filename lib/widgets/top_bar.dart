import 'package:biteupcontent/pages/others/account_page.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final bool isScrolled;

  const CustomSliverAppBar({
    Key? key,
    required this.isScrolled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: isScrolled ? Colors.pink[400] : Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Food Image Section with gradient overlay
            Container(
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/healthy-eating-ingredients-1296x728-header.jpg?w=1155&h=1528'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            // Restaurant Info Section
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'P.S. Mali',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow[600], size: 16),
                            const SizedBox(width: 4),
                            const Text(
                              '4.8',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Free',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        titlePadding: EdgeInsets.zero,
        title: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isScrolled ? kToolbarHeight : 0,
          // color: Colors.pink[400],
          child: isScrolled
              ? Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Biteup',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Shivajinagar, Pune',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
              : const SizedBox(),
        ),
      ),
      leading: InkWell(
        onTap: ()=>{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPage()))
        },
        child: Icon(
          Icons.person_outline,
          color: Colors.white,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

