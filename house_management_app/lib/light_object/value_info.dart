import 'package:flutter/material.dart';

class ValueInfo extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final double value;
  final String unit;

  const ValueInfo({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            icon,
            color: iconColor,
            size: 45.0,
          ),
        ),
        Title(
          color: Colors.black,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 140),
        Title(
          color: Colors.black,
          child: Text(
            "${value} $unit",
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
