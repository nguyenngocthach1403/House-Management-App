import 'package:flutter/material.dart';

class Room {
<<<<<<< Updated upstream
  final iconLight;
  final iconC;
  final iconWater;
  late final textLight;
  late final textC;
  late final textWater;
=======
  final IconData iconLight;
  final IconData iconC;
  final IconData iconWater;
  late final String textLight;
  late final String textC;
  late final String textWater;
>>>>>>> Stashed changes
  final String roomName;

  Room({
    required this.iconLight,
    required this.iconC,
    required this.iconWater,
    required this.textLight,
    required this.textC,
    required this.textWater,
    required this.roomName,
  });
}

class ListRoom extends StatelessWidget {
  final Room room;

<<<<<<< Updated upstream
  ListRoom({Key? key, required this.room}) : super(key: key);
=======
  ListRoom({
    Key? key,
    required this.room,
  }) : super(key: key);
>>>>>>> Stashed changes

  final LinearGradient gradient = const LinearGradient(
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
          borderRadius: const BorderRadius.all(Radius.circular(7)),
        ),
        child: Column(
          children: [
<<<<<<< Updated upstream
            Text(
              room.roomName,
              style: const TextStyle(fontWeight: FontWeight.bold),
=======
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                room.roomName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[300]),
              ),
>>>>>>> Stashed changes
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    room.iconLight,
                    size: 45,
                    color: Colors.yellow[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      room.textLight,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
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
                  Icon(room.iconC, size: 40, color: Colors.red),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      room.textC,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
<<<<<<< Updated upstream
                  )
=======
                  ),
>>>>>>> Stashed changes
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    room.iconWater,
                    size: 45,
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      room.textWater,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
