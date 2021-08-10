import 'package:flutter/material.dart';
import 'package:Blackdog/components/reusable_card.dart';
import 'package:Blackdog/components/card_content.dart';
import 'package:Blackdog/screens/city_screen.dart';
import 'package:Blackdog/services/weather_model.dart';
import 'package:Blackdog/utilities/constants.dart';

class WeatherView extends StatefulWidget {
  WeatherView({this.locationWeather});

  final locationWeather;
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherModel weatherModel = WeatherModel();
  dynamic temperature;
  dynamic feelsLike;
  dynamic pressure;
  dynamic humidity;
  dynamic windSpeed;
  dynamic countryName;
  dynamic cityName;
  dynamic weatherDescription;
  IconData weatherIcon;
  Color weatherIconColor;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        return;
      } else {
        temperature = weatherData['main']['temp'];
        feelsLike = weatherData['main']['feels_like'];
        pressure = weatherData['main']['pressure'];
        humidity = weatherData['main']['humidity'];
        windSpeed = weatherData['wind']['speed'];
        countryName = weatherData['sys']['country'];
        cityName = weatherData['name'];
        weatherDescription = weatherData['weather'][0]['description'];
        weatherIcon = weatherModel.getWeatherIcon(weatherData);
        weatherIconColor =
            weatherModel.getColor(weatherData['weather'][0]['id']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = (MediaQuery.of(context).size.width - 100)/2;
    Color gradientStart;
    Color gradientEnd;
    var now = DateTime.now().hour;
    if (now >= 17) {
      gradientStart = Colors.blueAccent;
      gradientEnd = Colors.deepPurple;
    } else {
      gradientStart = Colors.yellow;
      gradientEnd = Colors.deepOrange;
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.near_me_rounded),
          tooltip: 'Update location',
          onPressed: () async {
            dynamic weatherData = await weatherModel.getLocationWeather();
            final snackBar = SnackBar(
              content: Text(
                'Weather updated!',
                style: TextStyle(color: Colors.blue.shade200),
              ),
              backgroundColor: Colors.black54,
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print(weatherData);
            setState(() {
              updateUI(weatherData);
            });
          },
        ),
        title: Text('Black Dog Test'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'City weather',
            onPressed: () async {
              var typedName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );
              if (typedName != null) {
                var weatherData = await weatherModel.getCityWeather(typedName);
                updateUI(weatherData);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientStart, gradientEnd]),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40.0),
              Text(
                '$cityName, $countryName',
                style: kPlaceTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Column(
                    children: [
                      Text(
                        '$temperature°C',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$weatherDescription',
                        style: TextStyle(
                            fontFamily: 'ComicNeue light', fontSize: 20.0),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    child: Icon(
                      weatherIcon,
                      size: 150.0,
                      color: weatherIconColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ReusableCard(
                    width: _width,
                    height: 260.0,
                    cardChild: CardContent(
                      title: 'Feels like',
                      icon: Icons.thermostat_rounded,
                      value: '$feelsLike °C',
                    ),
                  ),
                  ReusableCard(
                    width: _width,
                    height: 260.0,
                    cardChild: CardContent(
                        title: 'Wind speed',
                        icon: Icons.all_inclusive_rounded,
                        value: '$windSpeed kmph'),
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ReusableCard(
                  width: double.infinity,
                  height: 160.0,
                  cardChild: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CardContent(
                          title: 'Pressure',
                          icon: Icons.compress,
                          value: '$pressure mb'),
                      CardContent(
                        title: 'Humidity',
                        icon: Icons.water_damage_rounded,
                        value: '$humidity %',
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
