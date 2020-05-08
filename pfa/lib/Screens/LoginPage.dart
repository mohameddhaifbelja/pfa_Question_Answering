import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'AppColors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String days = "  ";
  String months = "  ";
  String years = "    ";

  @override
  Widget build(BuildContext context) {
    var screen_height = MediaQuery.of(context).size.height;
    var screen_width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Stack(
                  children: <Widget>[
                    Transform.rotate(
                      angle: 3.14,
                      child: WaveWidget(
                        duration: 1,
                        config: CustomConfig(
                          gradients: [
                            [AppColors.darkBlue, AppColors.lightBlue],
                            [
                              AppColors.darkBlue.withOpacity(0.8),
                              AppColors.lightBlue.withOpacity(0.8)
                            ],
                          ],
                          durations: [30000, 19440],
                          heightPercentages: [0, 0],
                          blur: MaskFilter.blur(BlurStyle.solid, 10),
                          gradientBegin: Alignment.topCenter,
                          gradientEnd: Alignment.bottomCenter,
                        ),
                        waveAmplitude: 20.0,
                        backgroundColor: Colors.white,
                        size: Size(double.infinity, double.infinity),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: double.infinity,
                        ),
                        Container(
                            height: screen_height * 0.3 * 0.7,
                            margin: EdgeInsets.only(
                                left: screen_width * 0.05,
                                top: screen_height * 0.3 * 0.2,
                                bottom: screen_height * 0.3 * 0.3),
                            child: Image.asset("assets/images/logo.png")),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: screen_height * 0.3 * 0.6),
                            child: Image.asset(
                              "assets/images/bubble.png",
                              width: screen_width * 0.6,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screen_width * 0.1,
                      vertical: screen_height * 0.02),
                  child: ListView(
                    children: <Widget>[
                      Text(
                        "First Name :",
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 24),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: AppColors.lightBoxColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Center(
                            child: TextField(
                              textAlign: TextAlign.center,
                              maxLength: 26,
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.textColor),
                              decoration: null,
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          "Date Of Birth :",
                          style: TextStyle(
                              color: AppColors.textColor, fontSize: 24),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var datePicked =
                              await DatePicker.showSimpleDatePicker(
                            context,
                            initialDate: DateTime(DateTime.now().year),
                            firstDate: DateTime(1960),
                            dateFormat: "dd-MMMM-yyyy",
                            locale: DateTimePickerLocale.en_us,
                            looping: true,
                            textColor: AppColors.textColor,
                          );

                          setState(() {
                            days = datePicked.day.toString();
                            months = datePicked.month.toString();
                            years = datePicked.year.toString();
                          });
                          print(datePicked.runtimeType);
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.lightBoxColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: this.days + "  ",
                                  style: TextStyle(
                                      fontSize: 24, color: AppColors.textColor),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '/  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                            color: AppColors.textColor)),
                                    TextSpan(
                                        text: this.months + "  ",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.textColor)),
                                    TextSpan(
                                        text: '/  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                            color: AppColors.textColor)),
                                    TextSpan(
                                        text: this.years,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.textColor)),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: screen_width * 0.8,
                            height: screen_height * 0.1,
                            decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.only(top: 20),
                            child: FlatButton(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 35),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
