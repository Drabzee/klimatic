import 'package:flutter/material.dart';
import '../models/weatherModel.dart';
import './searchCity.dart';
import 'package:strings/strings.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState('New Delhi');
  }
}

class _HomePageState extends State<HomePage> {

  String weatherCity;

  _HomePageState(this.weatherCity);

  ImageProvider getBackgroundImage(String desc) {
    if(desc.contains('thunderstorm'))
      return AssetImage('assets/backgrounds/bg_thunder.jpg');
    else if(desc.contains('snow') || desc.contains('sleet'))
      return AssetImage('assets/backgrounds/bg_snow.jpg');
    else if(desc.contains('rain') || desc.contains('drizzle'))
      return AssetImage('assets/backgrounds/bg_rain.jpg');
    else if(desc.contains('clear'))
      return AssetImage('assets/backgrounds/bg_clear.jpg');
    else if(desc.contains('clouds'))
      return AssetImage('assets/backgrounds/bg_cloudy.jpg');
    else
      return AssetImage('assets/backgrounds/bg_fog.jpg');
  }

  Image getWeatherLogo(String desc) {
    if(desc.contains('thunderstorm'))
      return Image.asset('assets/weather_logo/rain_thunder.png');
    else if(desc.contains('snow') || desc.contains('sleet'))
      return Image.asset('assets/weather_logo/snow_fall.png');
    else if(desc.contains('rain') || desc.contains('drizzle'))
      return Image.asset('assets/weather_logo/rain_thunder.png');
    else if(desc.contains('clear'))
      return Image.asset('assets/weather_logo/clear.png');
    else
      return Image.asset('assets/weather_logo/cloudy_dense.png');
  }

  TextStyle getDescStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );
  }

  Widget getFoundView(AsyncSnapshot snapshot) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: getBackgroundImage(snapshot.data.desc),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              alignment: Alignment.centerRight,
              child: Text(
                '${snapshot.data.city}',
                style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)
              )
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: getWeatherLogo(snapshot.data.desc)
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                '${snapshot.data.temp}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 55.0,
                ),
                textAlign: TextAlign.left,
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal:65.0),
              child: Text('Description : ${capitalize(snapshot.data.desc)}', style: getDescStyle())
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 65.0),
              child: Text('Humidity : ${snapshot.data.humidity}', style: getDescStyle())
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 65.0),
              child: Text('Min : ${snapshot.data.minTemp}°C', style: getDescStyle())
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 65.0),
              child: Text('Max : ${snapshot.data.maxTemp}°C', style: getDescStyle())
            ),
            Expanded(
              flex: 1,
              child: Container()
            )
          ],
        ),
      );
  }

  Widget getNotFoundView() {
    return Center(
      child: Text('Oopps! No such city found'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Klimatic'),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String oldCity = weatherCity;
              weatherCity = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SearchCity())) ?? oldCity;
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchWeather(city: weatherCity),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data.status == 200) {
              return getFoundView(snapshot);
            }
            else if(snapshot.data.status == 404) {
              return getNotFoundView();
            }
          }
          else if(snapshot is String) {
            return Center(
              child: Text('${snapshot.data}')
            );
          }
          else if(snapshot.hasError) {
            return Center(
              child:Text('${snapshot.error}')
            );
          }
          return Center(
            child : CircularProgressIndicator()
          );
        }
      )
    );
  }
}