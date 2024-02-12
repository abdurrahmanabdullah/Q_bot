import 'package:flutter/material.dart';

/// Reusable widget
/// Next and Hold token widget

class QCardWaitingWidget extends StatelessWidget {
  const QCardWaitingWidget({
    Key? key,
    required this.token,
    this.counterCategory,
  }) : super(key: key);

  final String token;
  final String? counterCategory;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: const Color(0xFFF7F7F7),
      width: size.width * 0.22,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                token.padLeft(3, '0'),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                ),
              ),
              if (counterCategory != null)
                Text(
                  '(${counterCategory!.toUpperCase()})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
            ],
          ),
          Container(
            height: 1,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFB9DA8C),
                    // Color(0xFFB8DA8D),
                    // Color(0xFF6BC3A5),
                    // Color(0xFF67C3A7),
                    Color(0xFF38BCBD),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ],
      ),
    );
  }
}
