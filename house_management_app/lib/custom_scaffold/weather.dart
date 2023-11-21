import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  Weather(
      {super.key,
      required this.weatherIcon,
      required this.weather,
      required this.temperature,
      required this.currentTime,
      required this.currentyDate});
  AssetImage weatherIcon;
  String weather;
  double temperature;
  String currentTime;
  String currentyDate;

  @override
  State<Weather> createState() => _WeatherState();
}

double toFahrenheit(double celsius) {
  return celsius * 1.8 + 32;
}

class _WeatherState extends State<Weather> {
  bool iscelsius = true;
  double? temperatureTemp;
  @override
  void initState() {
    super.initState();
    temperatureTemp = widget.temperature;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 5,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: widget.weatherIcon)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    widget.weather,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 5,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (iscelsius) {
                        temperatureTemp = toFahrenheit(widget.temperature);
                      } else {
                        temperatureTemp = widget.temperature;
                      }
                      iscelsius = !iscelsius;
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 45,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              temperatureTemp.toString(),
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Text(
                                "o",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Text(
                              iscelsius ? "C" : "F",
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Temperature",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 5,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 45,
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        widget.currentTime,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    widget.currentyDate,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
