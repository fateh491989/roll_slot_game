import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'BouncingWidget.dart';
//import 'MyHomePage.dart';
import 'ListViewWidget.dart';
List _data = [
  'Apple',
  'Banana',
  'PanCake',
  'Mango',
  'Berry',
  'Cat',
  'Dog'
];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage()
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> with TickerProviderStateMixin{

  Animation<Offset> _animation1,_animation2,_animation3;
  AnimationController _animationController1,_animationController2,_animationController3;
  CurvedAnimation _curvedAnimation1,_curvedAnimation2,_curvedAnimation3;
  // For each slot make a controller
  TrackingScrollController
    _trackingScrollController1,
    _trackingScrollController2,
    _trackingScrollController3;

  bool slot1ListVisible=true, // Used for slot 1 to toggle between List and Resulted Item
       slot2ListVisible=true, // Used for slot 2 to toggle between List and Resulted Item
       slot3ListVisible=true, // Used for slot 3 to toggle between List and Resulted Item
       result=false,       // Used to check whether you win or lose
       isPlaying=false;
  int random1=0, // will store random number for Slot 1
      random2=0, // will store random number for Slot 2
      random3=0; // will store random number for Slot 3
  double _height = 100;
  double _width = 100;
  Offset beginAnimation = Offset(0,5);



  @override
  void initState() {
    super.initState();
     _trackingScrollController1= TrackingScrollController();
     _trackingScrollController2 = TrackingScrollController();
     _trackingScrollController3 = TrackingScrollController();
    // For Slot one
    _animationController1 = AnimationController(vsync: this,duration: Duration(seconds: 1));
    _curvedAnimation1 = CurvedAnimation(parent: _animationController1, curve: Curves.bounceOut);
    _animation1 = Tween<Offset>(begin: beginAnimation,end: Offset(0,0)).animate(_curvedAnimation1);
    // For Slot two
    _animationController2 = AnimationController(vsync: this,duration: Duration(seconds: 1));
    _curvedAnimation2 = CurvedAnimation(parent: _animationController2, curve: Curves.bounceOut);
    _animation2 = Tween<Offset>(begin: beginAnimation,end: Offset(0,0)).animate(_curvedAnimation2);
    // For Slot three
    _animationController3 = AnimationController(vsync: this,duration: Duration(seconds: 1));
    _curvedAnimation3 = CurvedAnimation(parent: _animationController3, curve: Curves.bounceOut);
    _animation3 = Tween<Offset>(begin: beginAnimation,end: Offset(0,0)).animate(_curvedAnimation3);
  }
  @override
  void dispose() {
    super.dispose();
    _trackingScrollController1.dispose();
    _trackingScrollController2.dispose();
    _trackingScrollController3.dispose();
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              isPlaying?(result==true?Text('Win',):Text('Lost')):Text('Hit Button to start'),
              SizedBox(height: 10,),
              IgnorePointer(
                ignoring: true,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.amber,
                      width: 5.0,
                      style: BorderStyle.solid
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Slot One
                      slot1ListVisible?
                      Container(
                        height: _height,
                        width: _width,
                        margin: EdgeInsets.all(10),
                        child: ListViewByFateh(list: _data, scrollController: _trackingScrollController1,height: _height,
                          width: _width,),
                      ): BouncingWidget(
                        text: _data[random1],
                        animation: _animation1,
                        height: _height,
                        width: _width,
                      ),
                      // Slot Two
                      slot2ListVisible?Container(
                        margin: EdgeInsets.all(10),
                        height: _height,
                        width: _width,
                        child: ListViewByFateh(list: _data, scrollController: _trackingScrollController2,height: _height,
                          width: _width,),
                      ): BouncingWidget(
                          text: _data[random2],
                          animation: _animation2,
                        height: _height,
                        width: _width,
                         ),
                      // Slot Three
                      slot3ListVisible?Container(
                        margin: EdgeInsets.all(10),
                        height: _height,
                        width: _width,
                        child: ListViewByFateh(list: _data, scrollController: _trackingScrollController3,height: _height,
                          width: _width,),
                      ): BouncingWidget(
                        text: _data[random3],
                        animation: _animation3,
                        height: _height,
                        width: _width,
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: isPlaying?resetGame:startGame,
                    child: Text(isPlaying?'Reset':'Start'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
  startGame(){
    setState(() {
      slot1ListVisible= true;
      slot2ListVisible=true;
      slot3ListVisible=true;

    });

    random1 = Random().nextInt(_data.length);
    random2 = Random().nextInt(_data.length);
    random3 = Random().nextInt(_data.length);
    print(random1);
    print(random2);
    print(random3);
    random1==random2&& random1==random3? result=true:result=false;
    // Controller One
    firstController();
    // Controller Two
    var _duration = Duration(seconds: 1);
    Timer(_duration,secondController);
    // Controller Three
    var _duration1 = Duration(seconds: 2);
    Timer(_duration1,thirdController);
  }
  resetGame(){
    setState(() {
      slot1ListVisible= true;
      slot2ListVisible=true;
      slot3ListVisible=true;
      isPlaying= false;
    });
  }
  firstController(){
    _trackingScrollController1.animateTo(_trackingScrollController1.position.maxScrollExtent,
        duration: Duration(milliseconds: 4000), curve: Curves.decelerate).catchError((e){
      print('Fateh $e');
    }).then((s){
      print(_trackingScrollController1.position.minScrollExtent);
      _trackingScrollController1.animateTo(random1*_height,
          duration: Duration(milliseconds: 5000), curve: Curves.decelerate).then((s){
        _animationController1.forward();
        _animationController1.addListener((){
          setState(() {

          });
        });
        setState(() {
          slot1ListVisible=false;
          print(result);
          isPlaying=true;
        });
      });

    });
  }
  secondController(){
    _trackingScrollController2.animateTo(_trackingScrollController2.position.maxScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate).then((s){
      _trackingScrollController2.animateTo(random2*_height,
          duration: Duration(milliseconds: 2000), curve: Curves.decelerate).then((s){
        _animationController2.forward();
        _animationController2.addListener((){
          setState(() {

          });
        });
        setState(() {
          slot2ListVisible=false;
        });
      });
    });
  }
  thirdController(){
    _trackingScrollController3.animateTo(_trackingScrollController3.position.maxScrollExtent,
        duration: Duration(milliseconds: 1500), curve: Curves.decelerate).then((s){
      _trackingScrollController3.animateTo(random3*_height,
          duration: Duration(milliseconds: 2000), curve: Curves.decelerate).then((s){
        _animationController3.forward();
        _animationController3.addListener((){
          setState(() {

          });
        });
        setState(() {
          slot3ListVisible=false;
        });
      });
    });
  }
}
