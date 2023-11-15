
import 'package:covid_19_tracker/Model/WorldStatesModel.dart';
import 'package:covid_19_tracker/Services/States_Service.dart';
import 'package:covid_19_tracker/View/Countries_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class World_State extends StatefulWidget {
  const World_State({super.key});

  @override
  State<World_State> createState() => _World_StateState();
}

class _World_StateState extends State<World_State> with TickerProviderStateMixin{

  late final AnimationController _controller=AnimationController(
      duration: Duration(seconds: 5),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList=<Color> [
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    States_Service states_service=States_Service();

    return Scaffold(
      appBar: AppBar(
        title: Text("World States"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

             FutureBuilder(
                 future: states_service.fetchWorldStatesRecords(),
                 builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        )
                    );
                  }else{
                    return Column(
                      children: [
                        PieChart(
                          chartRadius: MediaQuery.of(context).size.width *3.2,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          dataMap: {
                            "Toatal": double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths!.toString())
                          },

                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusebleRow(title: "Total Casees", value: snapshot.data!.cases.toString()),
                                ReusebleRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ReusebleRow(title: "Recover", value: snapshot.data!.recovered.toString()),
                                ReusebleRow(title: "Active", value: snapshot.data!.active.toString()),
                                ReusebleRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                ReusebleRow(title: "Today deaths", value: snapshot.data!.todayDeaths.toString()),
                                ReusebleRow(title: "Today recovered", value: snapshot.data!.todayRecovered.toString()),
                                ReusebleRow(title: "Today cases", value: snapshot.data!.todayCases.toString()),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Countries_List(),));
                       },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(child: Text("Tracking Countries"),),
                          ),
                        )
                      ],
                    );
                  }
                 },
             ),

            ],
          ),
          
        ),
      ),
    );
  }
}
class ReusebleRow extends StatelessWidget {
  String title, value;
  ReusebleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
              SizedBox(height: 5,),
              Divider(height: 1, color: Colors.black,)
            ],
          ),
    );
  }
}
