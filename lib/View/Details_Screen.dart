import 'package:covid_19_tracker/View/World_States.dart';
import 'package:flutter/material.dart';

class Details_Screen extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalRecovered, totalDeaths, active, todayRecovered, test, critical;
  Details_Screen({
    super.key, required,
  required this.image,
  required this.name,
  required this.totalCases,
  required this.totalRecovered,
  required this.totalDeaths,
  required this.active,
  required this.todayRecovered,
  required this.test,
  required this.critical
  });

  @override
  State<Details_Screen> createState() => _Details_ScreenState();
}

class _Details_ScreenState extends State<Details_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      ReusebleRow(title: "Casees", value: widget.totalCases.toString()),
                      ReusebleRow(title: "Recovered", value: widget.totalRecovered.toString()),
                      ReusebleRow(title: "Deaths", value: widget.totalDeaths.toString()),
                      ReusebleRow(title: "Critical", value: widget.critical.toString()),
                      ReusebleRow(title: "Test", value: widget.test.toString()),
                      ReusebleRow(title: "Actvie", value: widget.active.toString()),
                      ReusebleRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                    ],

                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  widget.image
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
