import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

void main()=>runApp(
    MaterialApp(title: "Weather App", home:Home(),debugShowCheckedModeBanner: false, ));

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}

class _HomeState extends State<Home>{

  List irbidImages=[

    'images/Irbid mosque and city.jpg',
    'images/Jordan-Irbid.jpg',
    'images/unnamed.jpg',
    //'images/unnamed.jpg',
    //'images/unnamed.jpg',
  ];

  var MyTemp;
  var MyDescription;
  var current;
  var Myhumidity;
  var MywindSpeed;

  Future getWeather()async{
    var apiUrl= Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Irbid&units=metric&appid=a4a69d73bb8e77b3ec3bf980b6b69cef');
    http.Response response = await http.get(apiUrl);
    var myresult=jsonDecode(response.body);
    setState(() {
      this.MyTemp=myresult['main']['temp'];
      this.MyDescription=myresult['weather'][0]['description'];
      this.current=myresult['weather'][0]['main'];
      this.Myhumidity=myresult['main']['humidity'];
      this.MywindSpeed=myresult['wind']['speed'];});
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Irbid Weather App"), backgroundColor: Colors.indigo,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.30,
            width: double.infinity,
            color: Colors.white,
            child:
            Center(
              child: Stack(
                children:[
                  ListView(
                    children:[
                      CarouselSlider(
                        options: CarouselOptions(initialPage: 0, autoPlay: true, autoPlayInterval: Duration(seconds: 2)),
                        items:
                        irbidImages.map((e){
                          return Container(child: Image.asset(e, fit: BoxFit.fill,),
                            margin: EdgeInsets.all(2),
                            width: MediaQuery.of(context).size.width,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ),
          Container(
            width: double.infinity,
            color: Colors.indigoAccent,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Text("Currently in Irbid", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),),),
                Text(MyTemp!=null? MyTemp.toString()+"\u00B0": "Loading..", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),),
                Padding(padding: EdgeInsets.all(10),
                  child: Text(current != null? current.toString() : "Loading.." , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),),
              ],
            ),
          ),
          Expanded(child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Temperature"),
                  trailing: Text(MyTemp != null?  MyTemp.toString()+"\u00B0": "Loading.."),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Weather"),
                  trailing: Text(MyDescription != null?  MyDescription.toString() : "Loading.."),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Tempera Humidity"),
                  trailing: Text(Myhumidity != null?  Myhumidity.toString() : "Loading.."),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("wind Speed"),
                  trailing: Text(MywindSpeed != null?  MywindSpeed.toString() : "Loading.."),
                ),
              ],
            ),
          ))
        ],
      ),


    );
  }}