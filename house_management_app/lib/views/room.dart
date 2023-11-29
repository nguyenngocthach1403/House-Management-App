import 'package:flutter/material.dart';

class ListRoom extends StatelessWidget {
  ListRoom(
      {super.key,
      required this.iconLight,
      required this.iconC,
      required this.iconWater,
      required this.textLight,
      required this.textC,
      required this.textWater});
  final iconLight;
  final iconC;
  final iconWater;
  final textLight;
  final textC;
  final textWater;
  final gradient = const LinearGradient(
    colors: [Colors.white, Colors.green],
    begin: FractionalOffset.topLeft,
    end: FractionalOffset.bottomRight,
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/settingscreen');
      },
      child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: MediaQuery.of(context).size.width / 3 - 2 * 5,
          //height: 500,//MediaQuery.of(context).size.width / 2 - 1 * 5,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
              gradient: gradient,
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          child: Column(
            children: [
              const Text(
                "Room Room",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      iconLight,
                      size: 45,
                      color: Colors.yellow[300],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        textLight,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(iconC, size: 40, color: Colors.red),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        textC,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      iconWater,
                      size: 45,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(textWater,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
