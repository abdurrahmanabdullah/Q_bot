import 'package:flutter/material.dart';

/// Reusable widget
/// Current serving token widget

class QCardWidget extends StatelessWidget {
  const QCardWidget({
    Key? key,
    required this.token,
    required this.counterNo,
    this.color = const Color(0xFFF7F7F7),
    this.textColor = Colors.black,
    this.textSize = 40,
    this.dividerColor = const Color(0xFF0033FF),
  }) : super(key: key);

  final String token;
  final String counterNo;
  final Color? color;
  final Color? textColor;
  final double? textSize;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          color: color,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: size.width * 0.2,
                child: Center(
                  child: Text(
                    token == '-1' ? ' ' : token.padLeft(3, '0'),
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: textSize,
                    ),
                  ),
                ),
              ),
              Container(
                height: 24,
                width: 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFB9DA8C),
                        // Color(0xFFB8DA8D),
                        // Color(0xFF6BC3A5),
                        // Color(0xFF67C3A7),
                        Color(0xFF38BCBD),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              SizedBox(
                width: size.width * 0.2,
                child: Center(
                  child: Text(
                    counterNo.padLeft(2, '0'),
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: textSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
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
                tileMode: TileMode.clamp),
          ),
          height: 1,
        )
      ],
    );
  }
}
