import 'package:flutter/material.dart';
import 'package:pfa/Screens/AppColors.dart';
import 'package:pfa/Screens/HomePage.dart';
import 'package:pfa/Screens/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int switcher;
  double _opacity=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switcher = 0;
  }

  @override
  Widget build(BuildContext context) {
    var screen_height = MediaQuery.of(context).size.height;
    var screen_width = MediaQuery.of(context).size.width;
    Future.delayed(Duration(milliseconds: 10), (){
      setState(() {
        this._opacity=1.0;
      });
    });
    Future.delayed(const Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        var x = prefs.getString('name');
        if (x==null || x=="") {
          this.switcher = 1;
        } else {
          this.switcher = 2;
        }
      });
    });
    switch (switcher) {
      case 0:
        return Material(
          child: SafeArea(
            child: Container(
              child: Center(
                  child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 5,
                    child: AnimatedOpacity(
                      duration: Duration(seconds:3 ),
                      opacity: _opacity,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.fill,
                            ),
                            width: screen_width * 0.5,
                            height: screen_height * 0.4,
                          ),
                          Container(
                            child: Text(
                              "DR WILLOW",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 56
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            child: Text(
                              "Your Health Companion",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )],
                      ),
                    ),
                  )
                ],
              )),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.lightBlue,AppColors.darkBlue],
                stops: [0, 1],
              )),
            ),
          ),
        );
      case 1:
        return LoginPage();
      case 2:
        return HomePage();
    }
  }
}
