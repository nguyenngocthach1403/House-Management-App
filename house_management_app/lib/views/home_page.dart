import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:house_management_app/custom_scaffold/weather.dart';
import 'package:house_management_app/views/feature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Feature> featureLst = List.filled(5, Feature(icon: Icons.abc));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child:
                    CircleAvatar(backgroundImage: AssetImage("images/h1.png")),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: ((context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20 - value * 20),
                      child: child,
                    ),
                  );
                }),
                child: const Text(
                  "Controll Panel",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.notifications_active, color: Colors.white),
                iconSize: 30,
              )
            ],
          ),
          backgroundColor: const Color.fromRGBO(58, 126, 111, 1),
          elevation: 0,
        ),
        backgroundColor: const Color.fromRGBO(58, 126, 111, 1),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Welcome Toan",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Weather(
                weatherIcon: AssetImage("images/icon/cloudy.png"),
                weather: "Good",
                currentTime: "20:20",
                currentyDate: "21/11/2023",
                temperature: 20,
              ),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
                        child: Text(
                          "Feature",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [

                        //     // Feature(
                        //     //   icon: Icons.wifi,
                        //     // ),
                        //     // Feature(
                        //     //   icon: Icons.alarm,
                        //     // ),
                        //     // Feature(icon: Icons.account_circle_outlined),
                        //     // Feature(icon: Icons.wifi_tethering),
                        //   ],
                        // ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                children: List.generate(featureLst.length,
                                    (index) => featureLst[index]),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
