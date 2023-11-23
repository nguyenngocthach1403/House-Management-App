import 'package:flutter/material.dart';

class Feature extends StatelessWidget {
  const Feature({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      width: MediaQuery.of(context).size.width / 4 - 3 * 5,
      height: MediaQuery.of(context).size.width / 4 - 3 * 5,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(53, 110, 95, 1),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Icon(
        icon,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
