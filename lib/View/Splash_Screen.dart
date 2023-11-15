import 'dart:async';
import 'package:covid_19_tracker/View/World_States.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> with TickerProviderStateMixin{

  /*late final AnimationController _controller=AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();*/
  late final AnimationController _controller=AnimationController(
    duration: Duration(seconds: 5),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
            ()=>
      Navigator.push(context, MaterialPageRoute(builder: (context)=>World_State()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text("Covid 19 demo"),
        centerTitle: true,
      ),*/
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [

            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                  child: Image(image: AssetImage('images/virus.png')),
                ),
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),

            Align(
              alignment: Alignment.center,
              child: Text("Covid 19 \nTracker App", style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold
              ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
