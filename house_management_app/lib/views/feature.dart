import 'package:flutter/material.dart';

class Feature extends StatefulWidget {
  Feature({super.key, required this.icon, required this.action});
  final Icon icon;
  VoidCallback action;

  @override
  State<Feature> createState() => _FeatureState();
}

class _FeatureState extends State<Feature> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        width: MediaQuery.of(context).size.width / 4 - 3 * 5,
        height: MediaQuery.of(context).size.width / 4 - 3 * 5,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(53, 110, 95, 1),
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: widget.icon,
      ),
    );
  }
}
