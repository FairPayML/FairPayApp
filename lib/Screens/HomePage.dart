import 'package:fairpay/Screens/FlightBooking.dart';
import 'package:fairpay/Screens/MakePrediction.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _index=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    color: Color(0xff468A62),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: ExactAssetImage('images/map.png'),
                        fit: BoxFit.cover)),
              ),
              Row(
                children: [
                  TextButton(onPressed: (){
                    setState(() {
                      _index=0;
                    });

                  }, child: Text('press me')),
                  TextButton(onPressed: (){
                    setState(() {
                      _index=1;
                    });

                  }, child: Text('press me')),
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 10, right: 10, top: 130),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffB3BABF)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: IndexedStack(
                  index: _index,
                  children: [
                    MakePrediction(),
                    BookingScreen()
                  ],
                ),
              ),
          ])
        ),
      ),
    );

  }
}
